# Dynamit PHP Code Day

Congratulations on making it to the Dynamit PHP Code Day. This is the final test of your practical abilities for the position of PHP Developer. Please consider your approach and be able to articulate it upon completion.

## Included

There are a few things included in this repository that you should be aware of:

- Data Directory `./data/`: This directory includes a several CSVs that will be necessary to successfully complete this code day.
- Vagrant `./VagrantFile` and `./vagrant`: This is a self provisioning virtual server that comes preinstalled with Ubuntu 18.04, Apache 2.4.29, MySQL 14.14, PHP 7.3.8, Redis 4.0.9 

## Requirements

In order to run the local development environment, your machine must have the following installed:

- Vagrant ( http://www.vagrantup.com )
- VirtualBox ( https://www.virtualbox.org/wiki/Downloads )

NOTE: If you are using a Dynamit machine, this will be installed already.

### Vagrant Setup

In order to spin up your local development server you need to start Vagrant.

```
cd <repository-root>
vagrant up
```

You can SSH into your virtual machine using `vagrant ssh` and the default user has `sudo` access if you want to go in and mess around.

### Host File Setup

In order to use a local domain name for this site, add the following to your hosts file:

```
192.168.33.101  codeday.local www.codeday.local
```

### Other Information

Some other information that you will need:

A database in MySQL was created for you to use. To connect, you will need the following information:
- host: `127.0.0.1`
- port: `3306`
- database: `codeday`
- username: `root`
- password: `root`

## Activity Overview

For this Code Day Activity you are being asked to create a RESTful API. You may use the internet to assist in this activity because, well, you have that access in the real world as well. The limiting factor here is time, it shouldn't be access. You can also use any tool or framework available that you would consider using, keeping in mind that you are applying for a PHP position.

Read over each of the steps and plan your approach as some of the first activities may be impacted by your approach to subsequent activities. Please accomplish as much as you can in this  time frame.

### Activity #1: Database 

Review the contents of the CSV files included in the `./data/` directory of this project. Create functionality within your code to create a database structure that will support working with this data.

Next, create functionality to import the data from the various CSV files into your database.

### Activity #2: API

Create a RESTful API to interact with the data in the database, making sure that you have provided basic CRUD interactions as a baseline.

### Activity #3: Other functionality 

- Create the ability for customers to purchase items from a specific store.
- Create functionality to report a customer's latest purchase.
- Create functionality to report the customer's most expensive purchase.
- Create functionality to report the total purchases by store per day.
- Create functionality to report the store that any customer purchases products at most frequently.

### Activity #4: Authentication

Create the ability for a system to register with the API and authenticate against all other API endpoints. The manner in which you do this is up to you.

### Activity #5: Testing

Create some manner to test the functionality of your API.

## Completion

When you have finished your code day, create a pull request into the original `master` branch of this repository (https://github.com/Dynamit/code-day-php) for the team to review.