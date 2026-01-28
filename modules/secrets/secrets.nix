{
  config,
  lib,
  pkgs,
  ...
}:

let
  revan = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA0HuVxjXvsoWYMkbXcxTmOp7nV2juIiIW2KHs7jny3R";
  pikachu = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICXOKIwkBttYlUFqwl7vu6GE8YSUfplYWlKXtU6GIuXB";

in
{
  "secret1.age".publicKeys = [ revan ];
}
