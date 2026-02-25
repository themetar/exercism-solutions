//
// This is only a SKELETON file for the 'Line Up' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const SUFFIXES = ["st", "nd", "rd"];

const isBetween = (number, min, max) => min <= number && number <= max

const ordinalSuffix = number => {
  if (isBetween(number % 100, 10, 20)) return "th";

  return SUFFIXES[(number % 10) - 1] || "th";
}

export const format = (customer, ticketNumber) => {
  return `${customer}, you are the ${ticketNumber}${ordinalSuffix(ticketNumber)} customer we serve today. Thank you!`
};
