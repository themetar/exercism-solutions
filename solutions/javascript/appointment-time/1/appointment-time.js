// @ts-check

/**
 * Create an appointment
 *
 * @param {number} days
 * @param {number} [now] (ms since the epoch, or undefined)
 *
 * @returns {Date} the appointment
 */
export function createAppointment(days, now = undefined) {
  const date = now ? new Date(now) : new Date();
  date.setDate(date.getDate() + days);
  return date;
}

/**
 * Generate the appointment timestamp
 *
 * @param {Date} appointmentDate
 *
 * @returns {string} timestamp
 */
export function getAppointmentTimestamp(appointmentDate) {
  return appointmentDate.toISOString();
}

/**
 * Get details of an appointment
 *
 * @param {string} timestamp (ISO 8601)
 *
 * @returns {Record<'year' | 'month' | 'date' | 'hour' | 'minute', number>} the appointment details
 */
export function getAppointmentDetails(timestamp) {
  const appointment = new Date(timestamp);
  return {
    year: appointment.getFullYear(),
    month: appointment.getMonth(),
    date: appointment.getDate(),
    hour: appointment.getHours(),
    minute: appointment.getMinutes()
  };
}

/**
 * Update an appointment with given options
 *
 * @param {string} timestamp (ISO 8601)
 * @param {Partial<Record<'year' | 'month' | 'date' | 'hour' | 'minute', number>>} options
 *
 * @returns {Record<'year' | 'month' | 'date' | 'hour' | 'minute', number>} the appointment details
 */

const whatToCall = {
  year: Date.prototype.setFullYear,
  month: Date.prototype.setMonth,
  date: Date.prototype.setDate,
  hour: Date.prototype.setHours,
  minute: Date.prototype.setMinutes,
}
export function updateAppointment(timestamp, options) {
  const appointment = new Date(timestamp);
  for (let option of Object.keys(options))
    whatToCall[option].call(appointment, options[option]);
  return getAppointmentDetails(appointment);
}

/**
 * Get available time in seconds (rounded) between two appointments
 *
 * @param {string} timestampA (ISO 8601)
 * @param {string} timestampB (ISO 8601)
 *
 * @returns {number} amount of seconds (rounded)
 */
export function timeBetween(timestampA, timestampB) {
  return Math.round((new Date(timestampB) - new Date(timestampA)) / 1000);
}

/**
 * Get available times between two appointment
 *
 * @param {string} appointmentTimestamp (ISO 8601)
 * @param {string} currentTimestamp (ISO 8601)
 */
export function isValid(appointmentTimestamp, currentTimestamp) {
  return new Date(appointmentTimestamp) > new Date(currentTimestamp);
}
