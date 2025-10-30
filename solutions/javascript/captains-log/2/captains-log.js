// @ts-check

const random = (scale = 1) => Math.random() * scale;
const randomBetween = (min, max) => min + random(max - min);

/**
 * Generates a random starship registry number.
 *
 * @returns {string} the generated registry number.
 */
export function randomShipRegistryNumber() {
  return `NCC-${Math.floor(randomBetween(1000, 10000))}`;
}

/**
 * Generates a random stardate.
 *
 * @returns {number} a stardate between 41000 (inclusive) and 42000 (exclusive).
 */
export function randomStardate() {
  return randomBetween(41000, 42000);
}

const PLANET_CLASSES = ['D', 'H', 'J', 'K', 'L', 'M', 'N', 'R', 'T', 'Y'];
/**
 * Generates a random planet class.
 *
 * @returns {string} a one-letter planet class.
 */
export function randomPlanetClass() {
  return PLANET_CLASSES[Math.floor(random(PLANET_CLASSES.length))];
}
