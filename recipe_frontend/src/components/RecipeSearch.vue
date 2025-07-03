<template>
  <div class="recipe-search-wrapper">
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
/* A wrapper to center content and limit its max width on large screens */
.recipe-search-wrapper {
  max-width: 1200px; /* Max width for the entire content area */
  margin: 0 auto; /* Centers the wrapper */
  padding: 1rem; /* Padding for small screens, scales up */
}

.recipe-search {
  /* Removed fixed padding from here as it's now on the wrapper */
  padding-bottom: 20px; /* Keep bottom padding */
}

h2 {
  text-align: center;
  margin-bottom: 1.5rem; /* Use rem for spacing */
  font-size: 1.8em; /* Default font size */
}

.search-input {
  display: flex; /* Use flexbox for input and button */
  flex-direction: column; /* Stack vertically by default (mobile-first) */
  gap: 0.8rem; /* Space between input and button */
  margin-bottom: 1.5rem; /* Space below the search group */
  align-items: stretch; /* Make items stretch to fill container */
}

.search-input input {
  flex-grow: 1; /* Allows input to take available space */
  padding: 0.8rem 1rem; /* Slightly more padding */
  border: 1px solid #ccc;
  border-radius: 6px; /* Slightly more rounded corners */
  font-size: 1rem; /* Use rem for font size */
}

.search-input button {
  padding: 0.8rem 1.5rem; /* Slightly more padding */
  background-color: #42b983;
  color: white;
  border: none;
  border-radius: 6px; /* Slightly more rounded corners */
  cursor: pointer;
  font-size: 1rem;
  transition: background-color 0.2s ease;
}

.search-input button:hover {
  background-color: #368a68;
}

.loading-message, .no-results-message, .initial-guidance, .error-message {
  margin-top: 1.5rem;
  text-align: center; /* Center these messages */
  font-style: italic;
  color: #666;
  font-size: 1rem;
}

.error-message {
  color: #d32f2f;
  font-weight: bold;
}

/* Recipe List Grid - Refined Breakpoints */
.recipe-list {
  display: grid;
  /* Mobile: 1 column */
  grid-template-columns: 1fr;
  gap: 1.5rem; /* Space between cards */
  margin-top: 1.5rem; /* Space from above content */
}

/* Tablet Layout (e.g., 600px and up) */
@media (min-width: 600px) {
  .recipe-search-wrapper {
    padding: 1.5rem; /* More padding on larger screens */
  }
  .search-input {
    flex-direction: row; /* Input and button side-by-side */
    /* Adjust input width for desktop */
  }
  .search-input input {
    max-width: 400px; /* Limit input width on larger screens */
  }
  .search-input button {
    flex-shrink: 0; /* Prevent button from shrinking */
  }
  .recipe-list {
    /* 2 columns on tablets */
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  }
}

/* Desktop Layout (e.g., 900px and up) */
@media (min-width: 900px) {
  h2 {
    font-size: 2.2em; /* Larger heading on desktop */
  }
  .recipe-list {
    /* 3 columns on desktops */
    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  }
}

/* Large Desktop Layout (e.g., 1200px and up) */
@media (min-width: 1200px) {
  .recipe-search-wrapper {
    padding: 2rem; /* More padding on very large screens */
  }
  .recipe-list {
    /* 4 columns on very large desktops, if desired */
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  }
}
</style>