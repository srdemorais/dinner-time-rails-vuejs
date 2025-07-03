<template>
  <div class="recipe-card">
    <img :src="recipe.image + '&w=300&h=200&c=sc&q=80'|| 'https://via.placeholder.com/150'" :alt="recipe.title" class="recipe-image" />
    <h3>{{ recipe.title }}</h3>
    <p class="recipe-times" v-if="recipe.prep_time || recipe.cook_time">
      <span v-if="recipe.prep_time">Prep: {{ recipe.prep_time }}</span>
      <span v-if="recipe.cook_time">Cook: {{ recipe.cook_time }}</span>
    </p>
    <div class="ingredients-section">
      <h4>Ingredients:</h4>
      <ul>
        <li v-for="(ingredient, index) in displayIngredients" :key="index">
          {{ ingredient }}
        </li>
      </ul>
      <button v-if="recipe.ingredients && recipe.ingredients.length > 3" @click="toggleShowAllIngredients">
        {{ showAllIngredients ? 'Show Less' : 'Show More' }}
      </button>
    </div>
    <div class="instructions-section" v-if="recipe.instructions">
      <h4>Instructions:</h4>
      <p>{{ truncatedInstructions }}</p>
      <button v-if="recipe.instructions.length > 150" @click="toggleShowAllInstructions">
        {{ showAllInstructions ? 'Show Less' : 'Show More' }}
      </button>
    </div>
    <p v-if="recipe.ratings" class="recipe-ratings">⭐ {{ parseFloat(recipe.ratings).toFixed(1) }}</p>
    <a :href="recipe.original_url" target="_blank" rel="noopener noreferrer" class="view-original-link" v-if="recipe.original_url">
      View Original Recipe
    </a>
  </div>
</template>

<script>
export default {
  name: 'RecipeCard',
  props: {
    recipe: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      showAllIngredients: false,
      showAllInstructions: false
    };
  },
  computed: {
    displayIngredients() {
      // Display only first 3 ingredients unless "Show More" is clicked
      return this.showAllIngredients ? this.recipe.ingredients : this.recipe.ingredients?.slice(0, 3);
    },
    truncatedInstructions() {
      const instructions = this.recipe.instructions || '';
      if (this.showAllInstructions || instructions.length <= 150) {
        return instructions;
      }
      return instructions.substring(0, 150) + '...';
    }
  },
  methods: {
    toggleShowAllIngredients() {
      this.showAllIngredients = !this.showAllIngredients;
    },
    toggleShowAllInstructions() {
      this.showAllInstructions = !this.showAllInstructions;
    }
  }
};
</script>

<style scoped>
.recipe-card {
  border: 1px solid #e0e0e0;
  border-radius: 8px;
  padding: 1rem; /* Use rem for padding */
  text-align: left;
  background-color: white;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out; /* Smooth hover effect */
}

.recipe-card:hover {
  transform: translateY(-5px); /* Lift card on hover */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15); /* More pronounced shadow */
}

.recipe-image {
  width: 100%;
  height: 180px; /* Keeping fixed height for now; adjust if images look bad */
  object-fit: cover;
  border-radius: 4px;
  margin-bottom: 0.8rem; /* Use rem for margin */
}

h3 {
  color: #333;
  margin-top: 0;
  margin-bottom: 0.6rem; /* Use rem for margin */
  font-size: 1.15em; /* Slightly adjusted font size */
  line-height: 1.3;
}

.recipe-times {
  font-size: 0.85em; /* Slightly adjusted font size */
  color: #555;
  margin-bottom: 0.8rem;
}
.recipe-times span {
  margin-right: 0.8rem;
}

.ingredients-section h4, .instructions-section h4 {
  margin-top: 1rem; /* Use rem for margin */
  margin-bottom: 0.4rem; /* Use rem for margin */
  color: #42b983;
  font-size: 1em; /* Ensure headings are readable */
}

.ingredients-section ul {
  list-style: disc inside;
  padding-left: 0;
  margin-bottom: 0.8rem;
}

.ingredients-section li {
  font-size: 0.88em; /* Slightly adjusted font size */
  color: #444;
  margin-bottom: 0.2rem;
}

.instructions-section p {
  font-size: 0.88em;
  line-height: 1.5;
  color: #444;
  margin-bottom: 0.8rem;
}

.recipe-card button {
  background: none;
  border: 1px solid #42b983;
  color: #42b983;
  padding: 0.4rem 0.8rem; /* Use rem for padding */
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.8em;
  margin-top: 0.5rem;
  align-self: flex-start;
  transition: background-color 0.2s ease, color 0.2s ease;
}

.recipe-card button:hover {
  background-color: #42b983;
  color: white;
}

.recipe-ratings {
  font-weight: bold;
  color: #ff9800;
  margin-top: 0.8rem;
  font-size: 0.9em;
}

.view-original-link {
  display: inline-block;
  margin-top: 1rem;
  color: #007bff;
  text-decoration: none;
  font-size: 0.88em;
  transition: color 0.2s ease, text-decoration 0.2s ease;
}

.view-original-link:hover {
  text-decoration: underline;
  color: #0056b3;
}

/* Media Query for smaller screens (e.g., very narrow phones) */
@media (max-width: 380px) {
  .recipe-card h3 {
    font-size: 1.1em; /* Make titles slightly smaller on very small screens */
  }
  .recipe-card .recipe-times,
  .recipe-card .ingredients-section li,
  .recipe-card .instructions-section p,
  .recipe-card .recipe-ratings,
  .recipe-card .view-original-link {
    font-size: 0.8em; /* Make text slightly smaller */
  }
}
</style>