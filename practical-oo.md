# Notes for Practical Object-Oriented Design in Ruby, by Sandi Metz

## Chapter 6: Acquiring Behavior Through Inheritance

“Inheritance provides a way to define two objects as having a relationship such that when the first receives a message that it does not understand, it automatically forwards, or delegates, the message to the second.”

Ruby has single inheritance. A **Superclass** has one or more **Subclasses**.

Sublasses are _specializations_ of the superclass. They must have everything that the superclass has, plus more. Example: Bicycle (Superclass) -> MountainBike, RoadBike, etc.

Superclass should be abstract, does not represent a whole object, just the bits that the others share.

Do not apply inheritance right away. It's better to wait to find out the correct abstraction, even if this means code duplication.

When creating a new abstract superclass from an existing class, it's better to promote code up bit by bit, so nothing specific remains in the superclass. “ the worst that can happen is that you will fail to find and promote the entire abstraction”. Otherwise, “you might accidentally leave remnants of concrete behavior behind. By definition this leftover concrete behavior does not apply to every possible new subclass”

Superclass can have default values that can be overwritten by the subclass. Every template method must be implemented to avoid errors. Even if the only reasonable implementation is return a useful error that is easy to understand. Like:

```
def default_tire_size
  raise NotImplementedError,
    "This #{self.class} cannot respond to:"
  end
end
```

Similarly, avoid coupling, subclasses should not know too much about the superclass. Avoid `super()`. Instead, use hook messages:

```
class Bicycle
  def initialize(args={})
    @size       = args[:size]
    @chain      = args[:chain]     || default_chain
    @tire_size  = args[:tire_size] || default_tire_size

    post_initialize(args)   
  end

  def post_initialize(args)
    nil
  end
end

class RoadBike < Bicycle
  def post_initialize(args)
    @tape_color = args[:tape_color]
  end
end
```

Bicycle both sends and implements `post_initialize`, and the subclass may override it if necessary.

## Chapter 7: Sharing Role Behavior with Modules

Behaviour can also be shared though _roles_, so it doesn't depend on a parent-children relationship. Roles can share specific behaviour, but also just message signature (like a `prepare_trip` method name that does different things). Related to chapter 5 Duck typing.

Classical vs Models — _is-a_ vs _behaves-like-a_

“Objects should manage themselves; they should contain their own behavior. If your interest is in object B, you should not be forced to know about object A if your only use of it is to find things out about B.”

Before starting to write a module, it's better to pick an arbitrary concrete class and implement the method there. Afterwards, we can extract the abstraction into a module that allows the behaviour to be shared. Like with superclasses, modules should apply the template method pattern: every method must be implemented to avoid errors. Even if the only reasonable implementation is return a useful error that is easy to understand.

Modules can be added to classes with `include Module_name`, so the instances gain access to the module's methods.

Modules can also be added with `extend` keyword, then the modules methods are _added_ to the instance.

“Superclasses should not contain code that applies to some, but not all, subclasses. This restriction also applies to modules: the code in a module must apply to all who use it.” If the abstraction cannot be correctly identified it might not exist. You should not check for the _type_ of something in order to know how to treat it. Subbtypes must be substitutable for their supertypes.

Hierarchies should be shallow and as narrow as possible.

## Chapter 8: Combining Objects with Composition

_is-a_ vs _behaves-like-a_ vs _has-a_

Composed object is a _role_, depends on the interface of the role, and has no life independent of its container. Agreggation may also exist, when the object exists on their own.

Composition is preferred over inheritance because it has fewer dependencies, but “Inheritance is a better solution when its use provides high rewards for low risk”

#### Costs of inheritance:

- Dependencies
- If the model is incorrect, a new behaviour might not fit, so new code will be harder to implement.
- A change in a superclass will have a great and broad impact

#### Benefits of composition

- Small, single responsibility principle
- Pluggable, interchangeable
- High change tolerance

#### Costs of composition

- The whole object composed by tiny parts may be harder to understand
- “The composed object must explicitly know which messages to delegate and to whom. Identical delegation code many be needed by many different objects; composition provides no way to share this code.”
