output "hello_world" {
  description = "Hello world output"
  value       = "Hello, World!"
}

output "tags" {
  description = "The tags"
  value       = local.tags
}
