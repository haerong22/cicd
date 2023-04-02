resource "null_resource" "cleanup" {
  provisioner "local-exec" {
    when = destroy
    command = "sh ./script/cleanup.sh"
  }
}
