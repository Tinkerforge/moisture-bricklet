/* moisture-bricklet
 * Copyright (C) 2013 Olaf Lüke <olaf@tinkerforge.com>
 *
 * moisture.c: Implementation of Moisture Bricklet messages
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#include "moisture.h"

#include "bricklib/bricklet/bricklet_communication.h"
#include "bricklib/drivers/adc/adc.h"
#include "brickletlib/bricklet_entry.h"
#include "brickletlib/bricklet_simple.h"
#include "config.h"

#define SIMPLE_UNIT_MOISTURE 0

const SimpleMessageProperty smp[] = {
	{SIMPLE_UNIT_MOISTURE, SIMPLE_TRANSFER_VALUE, SIMPLE_DIRECTION_GET}, // TYPE_GET_MOISTURE
	{SIMPLE_UNIT_MOISTURE, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_SET}, // TYPE_SET_MOISTURE_CALLBACK_PERIOD
	{SIMPLE_UNIT_MOISTURE, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_GET}, // TYPE_GET_MOISTURE_CALLBACK_PERIOD
	{SIMPLE_UNIT_MOISTURE, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_SET}, // TYPE_SET_MOISTURE_CALLBACK_THRESHOLD
	{SIMPLE_UNIT_MOISTURE, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_GET}, // TYPE_GET_MOISTURE_CALLBACK_THRESHOLD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_SET}, // TYPE_SET_DEBOUNCE_PERIOD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_GET}, // TYPE_GET_DEBOUNCE_PERIOD
};

const SimpleUnitProperty sup[] = {
	{moisture_from_analog_value, SIMPLE_SIGNEDNESS_INT, FID_MOISTURE, FID_MOISTURE_REACHED, SIMPLE_UNIT_MOISTURE}, // moisture
};

const uint8_t smp_length = sizeof(smp);


void invocation(const ComType com, const uint8_t *data) {
	switch(((MessageHeader*)data)->fid) {
		case FID_GET_MOISTURE:
		case FID_SET_MOISTURE_CALLBACK_PERIOD:
		case FID_GET_MOISTURE_CALLBACK_PERIOD:
		case FID_SET_MOISTURE_CALLBACK_THRESHOLD:
		case FID_GET_MOISTURE_CALLBACK_THRESHOLD:
		case FID_SET_DEBOUNCE_PERIOD:
		case FID_GET_DEBOUNCE_PERIOD: {
			simple_invocation(com, data);
			break;
		}

		case FID_SET_MOVING_AVERAGE: {
			set_moving_average(com, (SetMovingAverage*)data);
			break;
		}

		case FID_GET_MOVING_AVERAGE: {
			get_moving_average(com, (GetMovingAverage*)data);
			break;
		}

		default: {
			BA->com_return_error(data, sizeof(MessageHeader), MESSAGE_ERROR_CODE_NOT_SUPPORTED, com);
			break;
		}
	}
}

void constructor(void) {
	_Static_assert(sizeof(BrickContext) <= BRICKLET_CONTEXT_MAX_SIZE, "BrickContext too big");

	adc_channel_enable(BS->adc_channel);

	PIN_AD_MOISTURE.type = PIO_INPUT;
	PIN_AD_MOISTURE.attribute = PIO_DEFAULT;
    BA->PIO_Configure(&PIN_AD_MOISTURE, 1);

    BC->moving_average_sum = 0;
    BC->moving_average_tick = 0;
    BC->moving_average_num = MOVING_AVERAGE_DEFAULT;
    for(uint8_t i = 0; i < MOVING_AVERAGE_MAX; i++) {
    	BC->moving_average[i] = 0;
    }

	simple_constructor();
}

void destructor(void) {
	simple_destructor();

	PIN_AD_MOISTURE.type = PIO_INPUT;
	PIN_AD_MOISTURE.attribute = PIO_PULLUP;
    BA->PIO_Configure(&PIN_AD_MOISTURE, 1);

	adc_channel_disable(BS->adc_channel);
}

int32_t moisture_from_analog_value(const int32_t value) {
	uint16_t analog_data = BA->adc_channel_get_data(BS->adc_channel);

	if (BC->moving_average_num == 0) {
		return analog_data;
	}

	BC->moving_average_sum = BC->moving_average_sum -
	                         BC->moving_average[BC->moving_average_tick] +
	                         analog_data;

	BC->moving_average[BC->moving_average_tick] = analog_data;
	BC->moving_average_tick = (BC->moving_average_tick + 1) % BC->moving_average_num;

	return (BC->moving_average_sum + BC->moving_average_num/2)/BC->moving_average_num;
}

void set_moving_average(const ComType com, const SetMovingAverage *data) {
	BC->moving_average_num = data->average;
	if(BC->moving_average_num > MOVING_AVERAGE_MAX) {
		BC->moving_average_num = MOVING_AVERAGE_MAX;
	}

	BA->com_return_setter(com, data);
}

void get_moving_average(const ComType com, const GetMovingAverage *data) {
	GetMovingAverageReturn gmar;
	gmar.header        = data->header;
	gmar.header.length = sizeof(GetMovingAverageReturn);
	gmar.average       = BC->moving_average_num;

	BA->send_blocking_with_timeout(&gmar, sizeof(GetMovingAverageReturn), com);
}

void tick(const uint8_t tick_type) {
	simple_tick(tick_type);
}
