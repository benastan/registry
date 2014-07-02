# Registry

Register stuff to stuff with stuff and stuff.

For a use case, see [sharespost/authorize](https://github.com/sharespost/authorize).

## Usage

Call `Registry` on your object:

```
class ClassWithRegistry
  Registry(self)
end
```

Your class now has a registry:

```
ClassWithRegistry.registry
=> {}
```

Register something:

```
ClassWithRegistry.register(:some_key, 'value to register') { 'proc to register' }
ClassWithRegistry.registry[:some_key]
=> ["value to register", #<Proc:0x007fb3e42036f0@(irb):13>]
```

You can give any object a registry:

```
string_with_registry = 'a'
Registry(string_with_registry)
string_with_registry.register(:a, 'b')
string_with_registry[:a]
=> 'b'
```