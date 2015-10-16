[ ![Codeship Status for stacy-wells/foster-network](https://codeship.com/projects/3c490800-4cc7-0133-1d1f-7691bbba1d6d/status?branch=master)](https://codeship.com/projects/106442)
![Code Climate](https://codeclimate.com/github/stacy-wells/foster-network.png)
[![Coverage Status](https://coveralls.io/repos/stacy-wells/foster-network/badge.svg?branch=master&service=github)](https://coveralls.io/github/stacy-wells/foster-network?branch=master)

# Foster Network

### About

Foster Network is a tool for non-profit animal rescues. It allows users to organize the animals in their care, and network them to find foster homes.

![alt text](http://i.imgur.com/WpeMG3S.jpg)

Users can import animals from their Petfinder account by entering their shelter ID.  

![alt text](http://i.imgur.com/8kEAG6k.png)

Animals that do not have an associated foster are displayed on the index page.  Here user can click 'Foster Me' to notify that animal's rescue via email that they have had a foster offer.

![alt text](http://i.imgur.com/udKyIjZ.jpg)

### The Basics

* Built with Ruby on Rails
* Backed with PostgreSQL database
* Foundation front end with custom CSS
* Designed to be responsive
* File uploading handled with [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) with storage in AWS
* User authentication with [Devise](https://github.com/plataformatec/devise)
* [Capybara](https://github.com/jnicklas/capybara) testing suite supported with [Factory Girl](https://github.com/thoughtbot/factory_girl)
* Configured with [Mandrill](http://mandrill.com/) for email deliveries
* Connected to [Petfinder's API](https://www.petfinder.com/developers/api-docs)


### Future Features

* Would love to implement a feature that prevents users from sending multiple emails to one address within a time period
* Create a way for users to crop their images to have a more uniform look for the index page
* Enable users to add more images and display them with a slideshow on the animal's show page
