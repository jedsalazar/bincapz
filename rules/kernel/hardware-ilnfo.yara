
rule sysctl_machdep {
	meta:
		description = "gets detailed hardware information using sysctl"
	strings:
		$ref = "kern.osproductversion"
		$ref2 = "machdep.cpu.vendor"
		$ref3 = "machdep.cpu.brand_string"
		$ref4 = "hw.cpufrequency"
	condition:
		2 of them
}