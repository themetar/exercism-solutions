// @ts-check

const random = (scale = 1) => Math.random() * scale;
/**
 * Generates a random starship registry number.
 *
 * @returns {string} the generated registry number.
 */
export function randomShipRegistryNumber() {
  return `NCC-${1000 + Math.floor(random(9000))}`;
}

/**
 * Generates a random stardate.
 *
 * @returns {number} a stardate between 41000 (inclusive) and 42000 (exclusive).
 */
export function randomStardate() {
  return 41000 + random(1000);
}

/**
 * Generates a random planet class.
 *
 * @returns {string} a one-letter planet class.
 */
const PLANET_CLASSES = ['D', 'H', 'J', 'K', 'L', 'M', 'N', 'R', 'T', 'Y'];
export function randomPlanetClass() {
  return PLANET_CLASSES[Math.floor(random(PLANET_CLASSES.length))];
}
