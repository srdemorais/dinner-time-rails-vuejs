<template>
  <div id="app">
    <header>
      <h1>It's Dinner Time! 🍽️</h1>
      <p>Find the most relevant recipes with ingredients you have at home.</p>
    </header>
    <main>
      <RecipeSearch />
    </main>
  </div>
</template>

<script>
import RecipeSearch from './components/RecipeSearch.vue';

export default {
  name: 'App',
  components: {
    RecipeSearch
  }
};
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

header {
  margin-bottom: 40px;
}

h1 {
  color: #42b983; /* Vue green */
}

main {
  max-width: 960px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}
</style>