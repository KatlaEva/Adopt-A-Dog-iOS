//
//  Identifiers.swift
//  Adopt-A-Dog
//
//  Created by Þórkatla Eva Víkingsdóttir on 05/05/2020.
//  Copyright © 2020 Þórkatla Eva Víkingsdóttir. All rights reserved.
//

import Foundation
import UIKit

struct Image {
    static let Logo = "Logo"
    static let UploadLogo = "upload_logo"
    static let favorite = "favorite"
    static let favoriteSelected = "favorite_selected"
    static let account = "account"
    static let accountSelected = "account_selected"
    static let home = "home"
    static let homeSelected = "home_selected"
    static let plus = "plus"
}

struct Title {
    static let appName = "Adopt-A-Dog"
    static let email = "E-mail"
    static let password = "Password"
    static let login = "Login"
    static let signup = "Signup"
    static let firstName = "First name"
    static let lastName = "Last name"
    static let moreInfo = "More info"
    static let back = "Back"
    static let myAccount = "My account"
    static let myDogs = "My dogs"
    static let contactInfo = "Contact information"
    static let myTales = "My tales"
    static let favorite = "Favorite"
    static let home = "Home"
    static let chooseImage = "Choose an image"
    static let name = "Name"
    static let age = "Age"
    static let breed = "Breed"
    static let writeAbout = "Write about your dog here..."
    static let save = "Save"
    static let edit = "Save changes"
    static let chooseFromLibrary = "Choose from library"
    static let newPhoto = "Take a new photo"
    static let cancel = "Cancel"
    static let chooseYourImage = "Choose your image"
    static let phoneNumber = "Phone number"
    static let signOut = "Sign out"
    static let searchPlaceholder = "Search by name, age or race here"
    static let noAccount = "Dont have an account? - Signup here!"
    static let hasAccount = "Allready have an accoung? - Login here!"
    static let noDogsListed = "You have no dogs listed, click on the + in the top right corner to put your dog up for adoption"
}

struct Cells {
    static let dogCell = "dogCell"
}

struct ConstantForDatabase {
    static let storageURL = "gs://adopt-a-dog-d14e1.appspot.com/"
    static let dogImage = "dogImage"
    static let imageTypeJPG = "image/jpg"
    static let dogCollection = "dogs"
    static let userCollection = "users"
}

struct ErrorMessage {
    static let firstNameNotValid = "First name not valid, must be at least two characters"
    static let lastNameNotValid = "Last name not valid, must be at least two characters"
    static let emailNotValid = "email not valid"
    static let passwordNotValid = "Pleas make sure your password is at least 8 characters, contains a special character and a numer."
    static let fillAllFields = "Pleas fill inn all fields"
    static let errorCreatingUser = "Error creating user"
    static let errorSavingUser = "Error saving user"
    static let incorrectEmailOrPassword = "Password or email is incorrect"
    static let signOutError = "Error signing out: %@"
}
