
rule php_possible_backdoor : critical {
  meta:
    hash_2020_trojan_webshell_quwmldl_rfxn = "f1375cf097b3f28247762147f8ee3755e0ce26e24fbf8a785fe4e5b42c1fed05"
    hash_2023_PHP_Backdoor_PHP_Goonshell_a = "42e5fafe25af2d2600691a26144cc47320ccfd07a224b72452dfa7de2e86ece3"
    hash_2023_PHP_Backdoor_PHP_Goonshell_a = "42e5fafe25af2d2600691a26144cc47320ccfd07a224b72452dfa7de2e86ece3"
    hash_2023_R57_Backdoor_PHP_R57_a = "3ab6322a2a14de6698446bc5e8faf741bbdad288e95c844edc9e318b722d956f"
    hash_2023_R57_Backdoor_PHP_R57_a = "3ab6322a2a14de6698446bc5e8faf741bbdad288e95c844edc9e318b722d956f"
    hash_2023_0xShell_0xShellori = "506e12e4ce1359ffab46038c4bf83d3ab443b7c5db0d5c8f3ad05340cb09c38e"
    hash_2023_0xShell_wesoori = "bab1040a9e569d7bf693ac907948a09323c5f7e7005012f7b75b5c1b2ced10ad"
  strings:
    $php = "php"
    $php_or = "<? "
    $f_base64_decode = "base64_decode"
    $f_strrev = "strrev"
    $f_rot13 = "str_rot13"
    $f_explode = "explode"
    $f_preg = "preg_replace"
    $f_serialize = "serialize"
    $f_gzinflate = "gzinflate"
    $f_remote_addr = "REMOTE_ADDR"
    $f_exec = "exec("
    $eval = "eval"
    $not_aprutil = "APR-UTIL"
    $not_syntax = "syntax file"
	$not_reference  = "stream_register_wrapper"
  condition:
    filesize < 1048576 and $eval and 1 of ($php*) and 4 of ($f_*) and none of ($not*)
}

rule php_eval_base64_decode : critical {
  meta:
    hash_2023_0xShell = "acf556b26bb0eb193e68a3863662d9707cbf827d84c34fbc8c19d09b8ea811a1"
    hash_2023_0xShell_0xObs = "6391e05c8afc30de1e7980dda872547620754ce55c36da15d4aefae2648a36e5"
    hash_2023_0xShell = "a6f1f9c9180cb77952398e719e4ef083ccac1e54c5242ea2bc6fe63e6ab4bb29"
    hash_2023_0xShell_0xShellObs = "64771788a20856c7b2a29067f41be9cb7138c11a2cf2a8d17ab4afe73516f1ed"
    hash_2023_0xShell_1337 = "657bd1f3e53993cb7d600bfcd1a616c12ed3e69fa71a451061b562e5b9316649"
    hash_2023_0xShell_index = "f39b16ebb3809944722d4d7674dedf627210f1fa13ca0969337b1c0dcb388603"
    hash_2023_0xShell_crot = "900c0453212babd82baa5151bba3d8e6fa56694aff33053de8171a38ff1bef09"
    hash_2023_0xShell_index = "f39b16ebb3809944722d4d7674dedf627210f1fa13ca0969337b1c0dcb388603"
  strings:
    $eval_base64_decode = "eval(base64_decode"
  condition:
    any of them
}

rule php_executor : critical {
  meta:
    hash_2020_trojan_webshell_quwmldl_rfxn = "f1375cf097b3f28247762147f8ee3755e0ce26e24fbf8a785fe4e5b42c1fed05"
    hash_2015_Resources_agent = "5a61246c9fe8e52347e35664e0c86ab2897d807792008680e04306e6c2104941"
    hash_2023_PHP_Backdoor_PHP_NShell = "a4f5649bb8356f0d78830c3e3ac032624dda4da5b5288190975aaa9c0cb4992f"
    hash_2023_PHP_Backdoor_PHP_NShell = "a4f5649bb8356f0d78830c3e3ac032624dda4da5b5288190975aaa9c0cb4992f"
    hash_2023_R57_Backdoor_PHP_R57_a = "3ab6322a2a14de6698446bc5e8faf741bbdad288e95c844edc9e318b722d956f"
    hash_2023_R57_Backdoor_PHP_R57_a = "3ab6322a2a14de6698446bc5e8faf741bbdad288e95c844edc9e318b722d956f"
    hash_2023_0xShell_0xShellori = "506e12e4ce1359ffab46038c4bf83d3ab443b7c5db0d5c8f3ad05340cb09c38e"
    hash_2023_0xShell_wesoori = "bab1040a9e569d7bf693ac907948a09323c5f7e7005012f7b75b5c1b2ced10ad"
  strings:
    $php = "<?php"
    $f_shell_exec = "shell_exec("
    $f_user = "get_current_user("
  condition:
    filesize < 1048576 and $php and all of ($f_*)
}

rule php_bin_hashbang : critical {
  meta:
    hash_2015_Resources_agent = "5a61246c9fe8e52347e35664e0c86ab2897d807792008680e04306e6c2104941"
    hash_2023_UPX_0a07c056fec72668d3f05863f103987cc1aaec92e72148bf16db6cfd58308617_elf_x86_64 = "94f4de1bd8c85b8f820bab936ec16cdb7f7bc19fa60d46ea8106cada4acc79a2"
  strings:
    $x_php = "<?php"
    $script = "#!/bin/"

	$not_php = "PHP_VERSION_ID"
  condition:
    $script and any of ($x*) and none of ($not*)
}

rule php_urlvar_recon_exec : critical {
  meta:
    ref = "Backdoor.PHP.Llama"
    hash_2023_PHP_Backdoor_PHP_Goonshell_a = "42e5fafe25af2d2600691a26144cc47320ccfd07a224b72452dfa7de2e86ece3"
    hash_2023_PHP_Backdoor_PHP_Llama = "8de0f8ef54bff5e3b694b7585dc66ef9fd5a4b019a6650b8a2211db888e59dac"
    hash_2023_PHP_Backdoor_PHP_NShell = "a4f5649bb8356f0d78830c3e3ac032624dda4da5b5288190975aaa9c0cb4992f"
    hash_2023_R57_Backdoor_PHP_R57_a = "3ab6322a2a14de6698446bc5e8faf741bbdad288e95c844edc9e318b722d956f"
    hash_2014_config_libpython2_7 = "6b0388aa64f1e31d86603309609fe295f650e66d518242375c483e1cf402d0b2"
    hash_2014_config_libpython2_7 = "6b0388aa64f1e31d86603309609fe295f650e66d518242375c483e1cf402d0b2"
    hash_2023_Sysrv_Hello_sys_x86_64 = "cd784dc1f7bd95cac84dc696d63d8c807129ef47b3ce08cd08afb7b7456a8cd3"
    hash_2023_0xShell_0xShellori = "506e12e4ce1359ffab46038c4bf83d3ab443b7c5db0d5c8f3ad05340cb09c38e"
  strings:
    $e_popen = "popen("
    $e_exec = "exec("
    $f_uname = "uname("
    $f_phpinfo = "phpinfo("
    $x_GET = "_GET"
    $x_POST = "_POST"

	$not_php = "PHP_VERSION_ID"
  condition:
    any of ($e*) and any of ($f*) and any of ($x*) and none of ($not*)
}

rule php_system_to_perl {
  meta:
    ref = "kinsing"
  strings:
    $php = "<?php"
    $system_perl = /system\([\'\"]perl/
  condition:
    all of them
}

rule php_eval_gzinflate_base64_backdoor : critical {
  meta:
    ref = "xoxo"
    hash_2023_0xShell_lndex = "9b073472cac7f3f8274165a575e96cfb4f4eb38471f6a8e57bb9789f3f307495"
    hash_2023_0xShell_lndex = "9b073472cac7f3f8274165a575e96cfb4f4eb38471f6a8e57bb9789f3f307495"
  strings:
    $f_eval = "eval("
    $f_html_special = "htmlspecialchars_decode"
    $f_gzinflate = "gzinflate("
    $f_base64_decode = "base64_decode"

	$not_php = "PHP_FLOAT_DIG" fullword
  condition:
    all of ($f*) and none of ($not*)
 }


rule php_obfuscated_with_hex_characters : critical {
  meta:
    hash_2023_0xShell_1337 = "657bd1f3e53993cb7d600bfcd1a616c12ed3e69fa71a451061b562e5b9316649"
    hash_2023_0xShell_index = "f39b16ebb3809944722d4d7674dedf627210f1fa13ca0969337b1c0dcb388603"
    hash_2023_0xShell_crot = "900c0453212babd82baa5151bba3d8e6fa56694aff33053de8171a38ff1bef09"
    hash_2023_0xShell_f = "9ce3da0322ee42e9119abb140b829efc3c94ea802df7a6f3968829645e1a5330"
    hash_2023_0xShell_index = "f39b16ebb3809944722d4d7674dedf627210f1fa13ca0969337b1c0dcb388603"
    hash_2023_0xShell_log_update = "9033a92496bec9e7e0fb41f1783c2b4d90187e1b4f50fe563ae5d5e83b66b1c8"
    hash_2023_0xShell_login = "7c8d783c489337251125204c4b7f9222d83058ed6872f55db1319a0be7337f05"
    hash_2023_0xShell_logout = "f8feafb93e55e75e9e52c5db3835e646e182b7910afa9152b112ff9d5a29a197"
  strings:
    $php = "<?php"
    $hex = /\\x\w{2}\w\\x/
    $hex_not_mix = /\\x\w{2}\w\\\d/
  condition:
    $php and (#hex > 5 or #hex_not_mix > 5)
}

rule php_base64_eval_uname : critical {
  meta:
    hash_2023_0xShell_root = "3baa3bfaa6ed78e853828f147c3747d818590faee5eecef67748209dd3d92afb"
    hash_2023_0xShell_wesoori = "bab1040a9e569d7bf693ac907948a09323c5f7e7005012f7b75b5c1b2ced10ad"
  strings:
    $eval = "eval("
    $html_special = "uname()"
    $base64_decode = "base64_decode"
  condition:
    all of them
}

rule php_post_system : suspicious {
  meta:
    hash_2023_0xShell_0xShellori = "506e12e4ce1359ffab46038c4bf83d3ab443b7c5db0d5c8f3ad05340cb09c38e"
    hash_2023_0xShell_root = "3baa3bfaa6ed78e853828f147c3747d818590faee5eecef67748209dd3d92afb"
    hash_2023_0xShell_untitled = "39b2fd6b4b2c11a9cbfc8efbb09fc14d502cde1344f52e1269228fc95b938621"
    hash_2023_0xShell_wesoori = "bab1040a9e569d7bf693ac907948a09323c5f7e7005012f7b75b5c1b2ced10ad"
    hash_2023_Sysrv_Hello_sys_x86_64 = "cd784dc1f7bd95cac84dc696d63d8c807129ef47b3ce08cd08afb7b7456a8cd3"
    hash_2023_UPX_0a07c056fec72668d3f05863f103987cc1aaec92e72148bf16db6cfd58308617_elf_x86_64 = "94f4de1bd8c85b8f820bab936ec16cdb7f7bc19fa60d46ea8106cada4acc79a2"
  strings:
    $php = "<?php"
    $method_post = "_POST"
    $method_get = "_GET"
    $system = "system("
  condition:
    $php and any of ($method*) and $system
}

rule php_error_reporting_disable : suspicious {
  meta:
    hash_2023_0xShell_0xShellori = "506e12e4ce1359ffab46038c4bf83d3ab443b7c5db0d5c8f3ad05340cb09c38e"
    hash_2023_0xShell_untitled = "39b2fd6b4b2c11a9cbfc8efbb09fc14d502cde1344f52e1269228fc95b938621"
    hash_2023_0xShell_wesoori = "bab1040a9e569d7bf693ac907948a09323c5f7e7005012f7b75b5c1b2ced10ad"
    hash_2023_systembc_password = "236cff4506f94c8c1059c8545631fa2dcd15b086c1ade4660b947b59bdf2afbd"
  strings:
    $error_reporting = "error_reporting(0)"
    $ini_set = "ini_set("
  condition:
    all of them
}

rule php_system_manipulation : suspicious {
  meta:
    hash_2023_0xShell_0xShellori = "506e12e4ce1359ffab46038c4bf83d3ab443b7c5db0d5c8f3ad05340cb09c38e"
    hash_2023_0xShell_untitled = "39b2fd6b4b2c11a9cbfc8efbb09fc14d502cde1344f52e1269228fc95b938621"
    hash_2023_0xShell_wesoori = "bab1040a9e569d7bf693ac907948a09323c5f7e7005012f7b75b5c1b2ced10ad"
  strings:
	$php = "<?php"
    $chdir = "chdir("
    $mkdir = "mkdir("
    $system = "system("
    $fopen = "fopen("
    $fwrite = "fwrite("
    $posix_getpwuid = "posix_getpwuid("
    $symlink = "symlink("
  condition:
    $php and 80% of them
}

rule php_system_hex : critical {
  meta:
    hash_2023_0xShell_root = "3baa3bfaa6ed78e853828f147c3747d818590faee5eecef67748209dd3d92afb"
    hash_2023_0xShell_untitled = "39b2fd6b4b2c11a9cbfc8efbb09fc14d502cde1344f52e1269228fc95b938621"
  strings:
    $system_hex = "system(\"\\x"
  condition:
    any of them
}

rule php_insecure_curl_uploader : critical {
  meta:
    hash_2023_0xShell_0xShellori = "506e12e4ce1359ffab46038c4bf83d3ab443b7c5db0d5c8f3ad05340cb09c38e"
    hash_2023_0xShell_f = "9ce3da0322ee42e9119abb140b829efc3c94ea802df7a6f3968829645e1a5330"
  strings:
    $CURLOPT_SSL_VERIFYPEER = "CURLOPT_SSL_VERIFYPEER"
	$php = "<?php"

    $f_file_get_contents = "file_get_contents"
    $f_eval = "eval"
    $f_stream_get_contents = "stream_get_contents"

	$not_php = "PHP_VERSION_ID"
  condition:
    $CURLOPT_SSL_VERIFYPEER and $php and any of ($f*) and none of ($not*)
}

rule php_eval_get_contents : critical {
  meta:
    hash_2023_0xShell_f = "9ce3da0322ee42e9119abb140b829efc3c94ea802df7a6f3968829645e1a5330"
  strings:
    $f_file_get_contents = "file_get_contents"
    $f_eval = "eval"
    $f_stream_get_contents = "stream_get_contents"
	$not_reference  = "stream_register_wrapper"
  condition:
    all of ($f*) and none of ($not*)
}

rule php_is_jpeg : critical {
  meta:
    hash_2023_0xShell_tifa_png = "1a13a6c6bb6815ba352b43971e4e961615367aec714e0a0005c28b3ebbc544c6"
  strings:
    $jfif = "JFIF"
    $icc_profile = "ICC_PROFILE"
    $php = "<?php"
  condition:
    all of them
}

rule php_copy_files : suspicious {
  meta:
    hash_2023_0xShell_0xShellori = "506e12e4ce1359ffab46038c4bf83d3ab443b7c5db0d5c8f3ad05340cb09c38e"
    hash_2023_0xShell_tifa_png = "1a13a6c6bb6815ba352b43971e4e961615367aec714e0a0005c28b3ebbc544c6"
    hash_2023_0xShell_up = "c72f0194a61dcf25779370a6c8dd0257848789ef59d0108a21f08301569d4441"
  strings:
    $copy_files = "@copy($_FILES"
  condition:
    all of them
}

rule php_base64_encoded : critical {
  meta:
    hash_2023_0xShell_0xObs = "6391e05c8afc30de1e7980dda872547620754ce55c36da15d4aefae2648a36e5"
    hash_2023_0xShell_0xShellObs = "64771788a20856c7b2a29067f41be9cb7138c11a2cf2a8d17ab4afe73516f1ed"
    hash_2023_0xShell_0xencbase = "50057362c139184abb74a6c4ec10700477dcefc8530cf356607737539845ca54"
    hash_2023_0xShell_memek = "2894f6a5725ec725ed4fab7c91a88a9a4c6444e549493868a05d30c9572ce17f"
    hash_2023_0xShell_wesobase = "17a1219bf38d953ed22bbddd5aaf1811b9380ad0535089e6721d755a00bddbd0"
    hash_2023_pan_chan_6896 = "6896b02503c15ffa68e17404f1c97fd53ea7b53c336a7b8b34e7767f156a9cf2"
    hash_2023_pan_chan_73ed = "73ed0b692fda696efd5f8e33dc05210e54b17e4e4a39183c8462bcc5a3ba06cc"
    hash_2023_pan_chan_99ed = "99ed2445553e490c912ee8493073cc4340e7c6310b0b7fc425ffe8340c551473"
  strings:
    $php = "<?php " base64
    $_POST = "$_POST" base64
    $_COOKIE = "$_COOKIE" base64
    $base64_decode = "base64_decode" base64
    $base64_encode = "base64_decode" base64
  condition:
    any of them
}
