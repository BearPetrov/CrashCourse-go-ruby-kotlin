# frozen_string_literal: true

require 'selenium-webdriver'
require 'capybara/rspec'
require_relative 'spec_helper'

RSpec.describe 'Login Tests' do
  include Capybara::DSL

  before(:each) do
    visit @url
  end

  context "Login with username and password" do
    usernames = ['standard_user']
    password = 'secret_sauce'
    usernames.each do |username|
      it "should be able to login with the username and password" do
        fill_in 'user-name', with: username
        fill_in 'password', with: password
        click_button 'Login'
        account_header = find(:xpath, '/html/body/div/div/div/div[1]/div[2]/span')
        expect(account_header.text).to eql "Products"
      end
    end
  end

  context "Login with username and incorrect password" do

    credentials = [{ username: 'standard_user', password: 'incorrectpassword' }]
    credentials.each do |user|
      it "don't should be able to login with the #{user[:username]} and #{user[:password]}" do
        fill_in 'user-name', visible: true, with: user[:username]
        fill_in 'password', visible: true, with: user[:password]
        click_button 'Login'
        error_message = find(:css, 'h3[data-test="error"]')
        expect(error_message.text).to include "Epic sadface: Username and password do not match any user in this service"
      end
    end
  end

  context "Login with wrong accounts" do

    credentials = [{ username: 'locked_out_user', password: 'secret_sauce' }, { username: 'error_user', password: 'secret_sauce' }]
    credentials.each do |user|
      it "don't should be able to login with the #{user[:username]} and #{user[:password]}" do
        fill_in 'user-name', visible: true, with: user[:username]
        fill_in 'password', visible: true, with: user[:password]
        click_button 'Login'
        expect(page).to have_no_css('[data-test="title"]')      
      end
    end
  end
end

RSpec.describe 'Add to cart test' do
  include Capybara::DSL

  before(:each) do
    visit @url
    
  end

  context "Add two items to cart" do
    usernames = ['standard_user']
    password = 'secret_sauce'
    usernames.each do |username|
      it "should be able to add two first items to cart" do
        fill_in 'user-name', with: username
        fill_in 'password', with: password
        click_button 'Login'
        click_button 'add-to-cart-sauce-labs-backpack'
        button = find(:css, '[data-test="remove-sauce-labs-backpack"]')
        expect(button.text).to eql "Remove"
        click_button 'add-to-cart-sauce-labs-bike-light'
        button = find(:css, '[data-test="remove-sauce-labs-bike-light"]')
        expect(button.text).to eql "Remove"

      end
    end
  end
end