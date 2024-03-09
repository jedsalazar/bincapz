
rule python_sysinfo_http : suspicious {
	meta:
		description = "exfiltrate system information"
	strings:
		$r_user = "getpass.getuser"
		$r_hostname = "socket.gethostname"
		$r_platform = "platform.platform"

		$u = /[\w\.]{0,16}urlopen/

	condition:
		filesize < 4096 and any of ($r*) and any of ($u*)
}

