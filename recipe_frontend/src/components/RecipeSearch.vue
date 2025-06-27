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

    <div v-if="loading" class="loading-message">
      Loading recipes...
    </div>

    <div v-if="recipes.length > 0" class="recipe-list">
      <RecipeCard v-for="recipe in recipes" :key="recipe.id" :recipe="recipe" />
    </div>
    <div v-else-if="!loading && searched" class="no-results-message">
      No recipes found with those ingredients. Try different ones!
    </div>
  </div>
</template>

<script>
import RecipeCard from './RecipeCard.vue'; // We will create this next

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
      searched: false // To show "No recipes found" only after a search attempt
    };
  },
  methods: {
    searchRecipes() {
      // API call logic will go here in the next step
      this.loading = true;
      this.searched = true;
      // Simulate API call for now
      setTimeout(() => {
        this.recipes = []; // Clear previous results
        this.loading = false;
        console.log('Searching for:', this.ingredientInput);
        // Example: If 'test' is in input, show dummy data
        if (this.ingredientInput.toLowerCase().includes('test')) {
            this.recipes = [
                { id: 1, title: 'Test Chicken Dish', ingredients: ['chicken', 'test ingredient'], instructions: 'Cook it', image: 'https://via.placeholder.com/150' },
                { id: 2, title: 'Test Veggie Meal', ingredients: ['broccoli', 'test ingredient'], instructions: 'Bake it', image: 'https://via.placeholder.com/150' }
            ];
        }
      }, 1000);
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
</style>