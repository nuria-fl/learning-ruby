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
