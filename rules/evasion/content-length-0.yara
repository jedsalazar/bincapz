rule content_length_0 : notable {
  meta:
	description = "Sets HTTP content length to zero"
  strings:
	$ref = "Content-Length: 0"
  condition:
	$ref
}


