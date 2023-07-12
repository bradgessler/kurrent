# README

I (stupidly) nerd sniped myself into some serious bikeshedding 😫 at https://twitter.com/bradgessler/status/1678897915857883136 after running into https://api.rubyonrails.org/classes/ActiveSupport/CurrentAttributes.html and trying to get everything working reasonably well from an instance.

I concluded it doesn't really matter; just do what makes sense for you. Here's a tour of those findings in case its helpful.

The one thing I do think is helpful is to consider functional approaches to integrating controller code with model code (or other contexts).

## Current class

The Current class at https://github.com/bradgessler/kurrent/blob/main/app/models/current.rb is a plain 'ol Ruby object that accepts a user as an argument and assigns everything.

## Controller integration

An instance of the Current class is created in the controller at https://github.com/bradgessler/kurrent/blob/main/app/controllers/application_controller.rb.

When a model is saved in a controller, I call `current.save @model` instead of `@model.save`, which you can see at https://github.com/bradgessler/kurrent/blob/main/app/controllers/messages_controller.rb. This is the "functional approach" to the problem. It also requires that all models confirm to everything done in the `#save` method at https://github.com/bradgessler/kurrent/blob/main/app/models/current.rb

### What if all models don't conform?

It's not hard to imagine the `Current#save` method from being littered with conditionals if not all models conform to having a `#creator=` method and `events` polymorphic relationship to `recordable`. To deal with that I'd recommend moving the `current#save` method into the controller as a concern and just calling `#save`. Then, in each controller where there's non-conformance, you'd override the `#save` method.

You can see an example of what this would look like at https://github.com/bradgessler/kurrent/blob/main/app/controllers/concerns/audited_save.rb, specifically I could override the `assign_current` method to handle a non-conformant model.

## Why did you even bother?

The example at https://api.rubyonrails.org/classes/ActiveSupport/CurrentAttributes.html showed a bunch of HTTP concerns being sucked into models. This kinda bugs me because when Rails apps get big, you'll need to do things outside of an HTTP context like process and inbound email, kick off a cronjob, or handle a support request from the Rails console.

I still think there's some legitemacy to that argument, but https://twitter.com/jorgemanru/status/1679004828779835393 points out that its a trade-off of purity for expresiveness. Makes sense! It's trade-offs all the way down.

A more exciting discovery I made is that the paradigm of `Current` might become more important in Rails as it moves more towards concurrency models that use Fibers, like running Rails on Falcon. More on that at https://twitter.com/ioquatix/status/1678993592684285954, but not much.
