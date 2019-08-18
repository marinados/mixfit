# GIVEN
## Product specs
- As a postman user I can submit my height and weight in the database (x)
- As a postman user I can enter my food intake for a specific day, represented by an amount (4 to 10) of Vitamin C, Vitamin D3 and Iron in the database (x)
- As a postman user I can enter my activity level, represented by a negative amount (1 to 3) of Vitamin C, Vitamin D3 and Iron in the database (x)
- As a postman user I can make a request so that I can get a personalized recipe based on the above values (check formula below)
- As another postman user I make the same request and have another result based on my personal values
- As a postman user I can see my personal recipes that have been generated, day by day

## Assumptions:
- At the beginning of the day, all 3 values are 0.
- We eat, then make the activity.
- At the end of the day, all 3 values must be 10.

## The formula
- The formula should take my values of Vitamin C, Vitamin D3 and Iron after I've eaten.
- It should subtract the activity level values from it.
- It should then complete that result to the total of 10/10.
- The output recipe should be the value that has been added in order to reach 10.

## Example: 
if I have:
5/10 in Vitamin C and my activity reduced it by 3,
7/10 in Vitamin D3 and my activity reduced it by 2,
4/10 in Iron and my activity reduced it by 1,

the output should show:
Vitamin C 8 (current level is 5-3 = 2)
Vitamin D3 5 (current level is 7-2 = 5)
Iron 7 (current level is 4-1 = 3)

# WHAT I HAVE DONE

## Assumptions
- a valid call to the daily activity or food intake endpoints does not have to contain all of the nutrients' params, it can only have one value (e.g. only iron or vitamin c).
- we don't limit the number of activities or food intakes per day, currently users can record as many as they wish.
- we don't restrict the number of personal recipes that can be requested either, currently users can generate a new one at any moment.
- they can generate a new recipe even if they don't have any food intakes or activities for the current day. It would have the target values for all nutrients then.
- a new recipe is not generated if the last values are identical to the new one.
- if the user's nutrients' levels are already above the threshold, we recommend a 0 intake in the recipe and even with negative current values we don't exceed the 10 unit dosage (precaution).


## Code structure
My primary purpose was to show a good deal of flexibility this exercise gives a developer. Depending on the leading coding guidelines accepted by the team the implementation of the given specs can be very different. 

### Framework
If I had choice over a framework in this case, it would definitely not be full-scale Rails, because it brings with it quite a number of modules that are not necessary in this case (I would probably opt for a basic Sinatra).
However, since the framework was the only technical requirement I had, I decided it would be interesting to implement both a classical Rails way of doing things and a more "independent", pure Ruby one.

The first approach has been shown in the `food_intake` and `user` part of the code. Here I have gone with the basic Rails structure of simple object creation directly in the controller and implementing all the validations within the ActiveRecord model.

The second one is using a builder pattern, where all of the underlying logic is implemented in a service builder object. This approach has to me an advantage of allowing to have multiple object-building contexts (non API, for instance) that would ask for different logic. And of course, they would be easier to unit test. In the given example I could have just as well done all of this with the classical Rails toolset, but I generally prefer to keep the use of callbacks to a minimum.

The calculation of the `personal_recipes` has been isolated in a builder object as well since it requires a certain transformation logic that has not much to do directly in the model. 

I have made a choice to store every recipe in the database although technically it can be re-calculated at any moment based on the activity and food intake of the day in question, but for performance reasons chances are much higher that we wouldn't want to re-calculate anything. 

Depending on the actual use case (e.g. an email or a PDF-creation with user related details), another option would be, instead of keeping recipes in the database, to put their generation into a background job. 
For an API it didn't make much sense, though, especially given that we cannot be sure to have the complete set of everyday data, since we rely on the API users to introduce it.

### Metaprogramming
I've kept the use of meta-programming to a minimum for readability purposes, but given the developer team has often got the specific naming conventions I was considering some meta for the recipe calculation, this could be easily added if the team accepts to use it this way.

### What can be improved further
- Since the app is very small, I almost didn't extract common code into concerns and modules. It can of course be done already at this stage, but I would say it's a bit early.
- API documentation, which is something I consider very important if the endpoints are intended for external use.
- Depending on the user load, some queries might need to be optimized.


