rule proc_exe : suspicious {
	meta:
		description = "Accesses the underlying executable of other processes"
	strings:
		$string = "/proc/%s/exe" fullword
		$digit = "/proc/%d/exe" fullword
		$python = "/proc/{}/exe" fullword
	condition:
		any of them
}
