#include "allergies.h"

bool is_allergic_to(allergen_t allergen, int allergy_score) {
  return (1 << allergen) & allergy_score;
}

allergen_list_t get_allergens(int allergy_score) {
  allergen_list_t list;

  list.count = 0;

  for (allergen_t allergen = ALLERGEN_EGGS; allergen < ALLERGEN_COUNT; allergen++) {
    if (is_allergic_to(allergen, allergy_score)) {
      list.count++;
      list.allergens[allergen] = true;
    }
  }

  return list;
}
