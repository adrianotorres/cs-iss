<h1 align="center"> CS INSS </h1>
<p align="center">
  <a href="https://github.com/adrianotorres/cs-iss/actions/workflows/ruby-tests.yml"><img src="https://github.com/adrianotorres/cs-iss/actions/workflows/ruby-tests.yml/badge.svg" alt="Ruby Tests" /></a>
  <a href="https://github.com/adrianotorres/cs-iss/actions/workflows/codeql.yml"><img src="https://github.com/adrianotorres/cs-iss/actions/workflows/codeql.yml/badge.svg" alt="CodeQL Analysing" /></a>
</p>

**CS INSS** is a system built with Ruby on Rails 7.1. It aims to provide a user-friendly interface for managing proponents, including save their data, calculate INSS discount and a Dashboard.

**Tech Stack**
* Ruby 3.1
* Rails 7.1
* PostgreSQL
* Redis
* Sidekiq

# ISS Calculator Implementation using Strategy Design Pattern

*Overview*

The InssCalculator class is responsible for calculating INSS (Brazilian Social Security) discounts based on various income brackets and corresponding tax rates. It employs the Strategy Design Pattern to encapsulate each calculation strategy within separate InssStrategy classes.

**`InssCalculator` Class**

`calculate_discount`
Main method responsible for calculating the total INSS discount. Iterates through a set of INSS strategies, applying each in order until the salary is fully taxed. Returns the total calculated discount.

`inss_strategies (private)`
Returns an array of InssStrategy objects, each representing a different income bracket and its corresponding tax rate.

**`InssStrategy` Class**
* **min_salary:** Minimum salary for the bracket.
* **max_salary:** Maximum salary for the bracket.
* **rate:** Tax rate for the bracket.
* **taxable_value:** Taxable value within the specific bracket.

`calculate_discount(salary, already_taxable)`

Calculates the discount for a given salary, considering the taxable amount within the bracket. Returns the calculated discount.

# Prerequisites
Make sure you have Ruby and Docker installed. If not, follow the installation steps below:

**Ruby Installation**

*For Linux (Ubuntu)*
```bash
sudo apt-get update
sudo apt-get install ruby-full
```
*For Mac*
```bash
brew install ruby
```

**Docker Installation**

*For Linux (Ubuntu)*
```bash
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
```
*For Mac*

Install Docker Desktop from the official website: https://www.docker.com/products/docker-desktop

Follow the installation instructions provided on the website

# Getting Started

1. Clone the project repository:
```bash
git clone https://github.com/adrianotorres/cs-inss.git
```
2. Install dip (Docker Interactive Processes) check more on https://github.com/bibendi/dip:
```bash
gem install dip
```
3. Initialize the env files:
```bash
cp .env{.example,.development} && cp .env{.example.test,.test}
```
4. Provision the application:
```bash
dip provision
```
5. Running application:
```bash
# Create the active record encription keys
dip rails db:encryption:init
# Copy above keys on credentials
dip rails credentials:edit
# Create database and initialize the application's data
dip rails db:prepare
# Run the application
dip dev
# User default
# email=csiss@mail.com
# password=admincsiss
```
6. Testing:
```bash
## Prepare test database
# Enter on container
dip runner
# Setup database
RAILS_ENV=test rails db:create
RAILS_ENV=test rails db:migrate
# Get out of the container
exit
## Run tests
dip test

# This app uses simple cov for coverage
# You can check the coverage report after test running on coverage folder
```

## Understanding the `dip dev` command

The `dip dev` command runs the docker-compose service `web` that execs the rails server and all dependency services (css, es-build, sidekiq, postgres, redis):

* **rails server:** Starts the Unicorn web server, responsible for handling web requests.
* **postgres:** Starts the PostgreSQL database server.
* **redis:** Starts the Redis in-memory data store.
* **sidekiq:** Starts the Sidekiq background worker process.
* **css:** Builds css in live watching mode.
* **es-build:** Builds and compiles js in live watching mode.

**Other dip's commands (you can always check it runnning `dip ls`)**
* **runner:** Open a Bash shell within a Rails container (with dependencies up)
* **bash:** Run an arbitrary script within a container (or open a shell without deps)
* **bundle:** Run Bundler commands
* **test:** Run RSpec commands
* **ci:** Check RSpec, rubocop
* **rubocop:** Run Rubocop commands
* **rails:** Run Rails commands
* **rails s:** Run Rails server at http://localhost:3000
* **dev:** Run dev stack (rails, yarn css and js, sidekiq and more)
* **yarn:** Run Yarn commands
* **psql:** Run Postgres psql console
* **redis-cli:** Run Redis console

**License:**

This project is licensed under the MIT License.
