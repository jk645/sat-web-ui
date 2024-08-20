# Swift Asset Tracker (SAT)

## Running Locally

To run locally for preview purposes, follow these steps:

1. Clone the repo to your local machine.
1. Ensure your working directory is the root folder of the repo (e.g. `cd sat-web-ui`).
1. Ensure Node.js and npm are already installed on your local machine. If not, you can install them by visiting: `https://nodejs.org/`
1. Run: `npm install`
1. After the installation is complete, run: `npm run preview`
1. Navigate in your web browser to: `http://localhost:3000/`
1. You should now see a sign-in screen.

To run for development purposes:

1. First follow the steps above to run for preview purposes. This ensures your local environment is set up.
1. Run: `npm run dev`
1. Navigate in your web browser to: `http://localhost:5173/`
1. You should now see the Single-Page-App, as it would look after a user has signed in.
1. As you make changes within the `sat-spa` folder, you should see them reflected in your web browser.

## Sections of the codebase

#### Single-Page-App

The Single-Page-App is located in the `sat-spa` folder. It is a Vue.js TypeScript project built with the Vite build tool. This is where the vast majority of feature development work takes place.

#### UI Asset Server

The UI Asset Server is located in the `sat-ui` folder. For now, it is simply an Express Node.js web application, built with the Express application generator tool. It exists as the gatekeeper to the Single-Page-App and thus provides a sign-in page. Listens at: `http://localhost:3000/`

TODO: To provide a sign-in page, thinking this might be changed to a Nest.js app, see: https://docs.nestjs.com/techniques/mvc

#### Mock API Server

The Mock API Server is located in the `sat-api` folder. It is a bare minimum Express Node.js web application. It primarily utilizes the OpenAPI Backend package to generate RESTful API endpoints from OpenAPI Spec files. But it can be used to provide any mock back-end API endpoints as needed for local development purposes. Listens at: `http://localhost:9000/`

## Contributing

TODO...

## Deploying

TODO...
