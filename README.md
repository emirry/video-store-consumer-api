# VideoStoreAPI

This Video Store API implementation is based on the Video Store API project that you have previously completed.

## Set Up Notes

You will need to acquire an API key from [The Movie Database](https://www.themoviedb.org/documentation/api) before you can run this project and this includes seeding the database.

## Functionality
This API comes pre-packaged with most of the functionality that you will require. The following endpoints are impemented, based off of the primary and optional requirements of the project.

### Customers

```
GET /customers
```
List all customers

### Videos

```
GET /videos
```
List all videos in the library

```
GET /videos?query=<search term>
```
Search for videos in the external Movie DB

```
GET /videos/:title
```
Show details for a single video by `title`

### Rentals

```
POST /rentals/:title/check-out
```
Check out one of the video's inventory to the customer. The rental's check-out date should be set to today.

```
POST /rentals/:title/return
```
Check in one of a customer's rentals

```
GET /rentals/overdue
```
List all customers with overdue videos
