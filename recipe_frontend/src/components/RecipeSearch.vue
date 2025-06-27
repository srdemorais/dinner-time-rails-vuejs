<template>
  <div class="recipe-search">
    <h2>What ingredients do you have?</h2>
    <div class="search-input">
      <input
        type="text"
        v-model="ingredientInput"
        @keyup.enter="searchRecipes"
        placeholder="e.g., chicken, rice, onion"
      />
      <button @click="searchRecipes">Find Recipes</button>
    </div>

    <div v-if="!searched && !loading && recipes.length === 0" class="initial-guidance">
      Enter some ingredients (e.g., "chicken, rice") to find recipes!
    </div>

    <div v-if="loading" class="loading-message">
      Loading recipes...
    </div>

    <div v-if="error" class="error-message">
      {{ error }}
    </div>

    <div v-if="recipes.length > 0" class="recipe-list">
      <RecipeCard v-for="recipe in recipes" :key="recipe.id || recipe.title" :recipe="recipe" />
    </div>
    <div v-else-if="!loading && searched && !error" class="no-results-message">
      No recipes found with those ingredients. Try different ones!
    </div>
  </div>
</template>

<script>
import RecipeCard from './RecipeCard.vue';
import axios from 'axios'; // Import axios

export default {
  name: 'RecipeSearch',
  components: {
    RecipeCard
  },
  data() {
    return {
      ingredientInput: '',
      recipes: [],
      loading: false,
      searched: false,
      error: null // To store any API error messages
    };
  },
  methods: {
    async searchRecipes() { // Make this method async
      this.loading = true;
      this.searched = true;
      this.error = null; // Clear previous errors

      try {
        const response = await axios.get(`${process.env.VUE_APP_API_BASE_URL}/recipes`, {
          params: {
            ingredients: this.ingredientInput // Send ingredientInput as 'ingredients' query parameter
          }
        });
        this.recipes = response.data; // Assign the fetched data to recipes
      } catch (err) {
        console.error('Error fetching recipes:', err);
        this.error = 'Failed to fetch recipes. Please try again later.';
        this.recipes = []; // Clear recipes on error
      } finally {
        this.loading = false;
      }
    }
  }
};
</script>

<style scoped>
.recipe-search {
  padding: 20px;
}

.search-input {
  margin-bottom: 30px;
}

.search-input input {
  width: 70%;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 4px;
  margin-right: 10px;
  font-size: 16px;
}

.search-input button {
  padding: 10px 20px;
  background-color: #42b983;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 16px;
}

.search-input button:hover {
  background-color: #368a68;
}

.loading-message, .no-results-message {
  margin-top: 20px;
  font-style: italic;
  color: #666;
}

.recipe-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.error-message {
  margin-top: 20px;
  color: #d32f2f; /* Red color for errors */
  font-weight: bold;
}

.initial-guidance {
  margin-top: 20px;
  color: #888;
  font-style: italic;
}
</style>