# Problem statement

### _It's dinner time!_ Create an application that helps users find the most relevant recipes that they can prepare with the ingredients that they have at home

## Objective

Deliver a prototype web application to answer the above problem statement.

__✅ Must have's__

- A back-end with Ruby on Rails (If you don't know Ruby on Rails, refer to the FAQ)
- A SQL-compliant relational database
- A well-thought user experience

__🚫 Don'ts__

- Excessive effort in styling
- Features which don't directly answer the above statement
- Over-engineer your prototype

## Deliverable

- The codebase should be pushed on the current GitHub private repository.
- 2 or 3 user stories that address the statement in your repo's `README.md`.
- The application accessible online (a personal server, fly.io or something else).
- Submission of the above via [this form](https://forms.gle/siH7Rezuq2V1mUJGA).
- If you're on Mac, make sure your browser has [permission to share the screen](https://support.apple.com/en-al/guide/mac-help/mchld6aa7d23/mac).


## Data

Please start from the following dataset to perform the assignment:
[english-language recipes](https://pennylane-interviewing-assets-20220328.s3.eu-west-1.amazonaws.com/recipes-en.json.gz) scraped from www.allrecipes.com with [recipe-scrapers](https://github.com/hhursev/recipe-scrapers)

Download it with this command if the above link doesn't work:
```sh textWrap
wget https://pennylane-interviewing-assets-20220328.s3.eu-west-1.amazonaws.com/recipes-en.json.gz && gzip -dc recipes-en.json.gz > recipes-en.json
```

## FAQ

<details>
<summary><i>I'm a back-end developer or don't know React, what do I do?</i></summary>

Just make the simplest UI, style isn't important and server rendered HTML pages will do!
</details>

<details>
<summary><i>Can I have a time extension for the test?</i></summary>

No worries, we know that unforeseen events happen, simply reach out to the recruiter you've been
talking with to discuss this.
</details>

<details>
<summary><i>Can I transform the dataset before seeding it in the DB</i></summary>

Absolutely, feel free to post-process the dataset as needed to fit your needs.
</details>

<details>
<summary><i>Should I rather implement option X or option Y</i></summary>

That decision is up to you and part of the challenge. Please document your choice
to be able to explain your reflexion and choice to your interviewer for the
challenge debrief.
</details>

<details>
<summary><i>I tried to make it available online but can't make it work</i></summary>

Don't overinvest time (or money) on this if you really can't figure it out and we'll
assess over your local version. Please make sure everything is working smoothly
locally before your debrief interview.
</details>

<details>
<summary><i>I don't know <b>Ruby on Rails</b></i></summary>

That probably means you're applying for a managerial position, so it's fine to
pick another language of your choice to perform this task.
</details>

## Application URL
- [Frontend application](https://recipe-frontend-vqn1.onrender.com/)
- [Backend api](https://srdemorais-recipe-api.onrender.com/api/v1) (e.g. curl -v "https://srdemorais-recipe-api.onrender.com/api/v1/recipes?ingredients=chicken,rice")

## User Stories

To address the problem statement and deliver a functional prototype, the following user stories guided the development process:

### 1. Backend API Development (Recipe Data Retrieval)

**As a frontend application (or an API consumer),**
**I want to be able to query the backend for recipes based on a list of provided ingredients,**
**so that I can efficiently retrieve relevant recipe data without complex client-side processing.**

* **Acceptance Criteria:**
    * The API accepts a list of ingredients (e.g., as a query parameter).
    * The API returns a JSON list of recipes that can be prepared with the provided ingredients.
    * The API response includes essential recipe details (e.g., title, description, ingredients list, instructions, and source URL if available).
    * The API is performant enough to respond within a reasonable time frame.

### 2. Frontend Development (User Recipe Search Experience)

**As a home cook,**
**I want an intuitive interface where I can easily input the ingredients I have at home and view a clear list of suitable recipes,**
**so that I can quickly decide what to cook and minimize food waste or manual searching.**

* **Acceptance Criteria:**
    * The interface provides a clear input field for ingredients.
    * Users can easily submit their ingredients to trigger a search.
    * Search results are displayed in a readable format, showing recipe titles and potentially key details.
    * Clicking on a recipe navigates to its full details (if applicable).
    * The UI handles cases with no matching recipes gracefully.

### 3. Application Deployment (Online Accessibility)

**As a user (or project stakeholder),**
**I want the recipe finder application to be accessible online via a stable URL,**
**so that I can use it anytime, anywhere, without needing a local setup, and demonstrate its functionality easily.**

* **Acceptance Criteria:**
    * Both the backend API and frontend application are deployed and publicly accessible.
    * The frontend can successfully make API requests to the deployed backend.
    * The application functions as expected (recipes can be searched and retrieved) when accessed through the public URL.
    * The deployment process is documented (implicitly, by the successful `README` submission).