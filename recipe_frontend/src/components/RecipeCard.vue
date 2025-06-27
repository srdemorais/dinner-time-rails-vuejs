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
  padding: 15px;
  text-align: left;
  background-color: white;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.08);
  display: flex;
  flex-direction: column;
  justify-content: space-between; /* Pushes button to bottom */
}

.recipe-image {
  width: 100%;
  height: 180px;
  object-fit: cover;
  border-radius: 4px;
  margin-bottom: 10px;
}

h3 {
  color: #333;
  margin-top: 0;
  margin-bottom: 10px;
  font-size: 1.2em;
}

.recipe-times {
  font-size: 0.9em;
  color: #555;
  margin-bottom: 10px;
}
.recipe-times span {
  margin-right: 10px;
}

.ingredients-section h4, .instructions-section h4 {
  margin-top: 15px;
  margin-bottom: 5px;
  color: #42b983;
}

.ingredients-section ul {
  list-style: disc inside;
  padding-left: 0;
  margin-bottom: 10px;
}

.ingredients-section li {
  font-size: 0.9em;
  color: #444;
  margin-bottom: 3px;
}

.instructions-section p {
  font-size: 0.9em;
  line-height: 1.5;
  color: #444;
  margin-bottom: 10px;
}

.recipe-card button {
  background: none;
  border: 1px solid #42b983;
  color: #42b983;
  padding: 5px 10px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 0.8em;
  margin-top: 5px;
  align-self: flex-start; /* Aligns button to the left */
}

.recipe-card button:hover {
  background-color: #e6f7ef;
}

.recipe-ratings {
  font-weight: bold;
  color: #ff9800; /* A nice orange for ratings */
  margin-top: 10px;
}

.view-original-link {
  display: inline-block;
  margin-top: 15px;
  color: #007bff;
  text-decoration: none;
  font-size: 0.9em;
}

.view-original-link:hover {
  text-decoration: underline;
}
</style>