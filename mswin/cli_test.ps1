if ($env:BUNDLER_VERSION) { Remove-Item env:\BUNDLER_VERSION }

$path = $env:PATH -Replace "[^;]+[Rr]uby[^;]+;",  ''
$env:PATH = "$pwd/$env:PRE/bin;$path"

ruby -ropenssl -e "puts RUBY_DESCRIPTION, OpenSSL::OPENSSL_LIBRARY_VERSION, ''"

$exit_code = 0

Write-Host "bundle version:" $(bundle version)
$exit_code += [int](0 + $LastExitCode)

Write-Host "gem  --version:" $(gem --version)
$exit_code += [int](0 + $LastExitCode)

Write-Host "irb  --version:" $(irb --version)
$exit_code += [int](0 + $LastExitCode)

Write-Host "racc --version:" $(racc --version)
$exit_code += [int](0 + $LastExitCode)

Write-Host "rake --version:" $(rake --version)
$exit_code += [int](0 + $LastExitCode)

Write-Host "rbs  --version:" $(rbs --version)
$exit_code += [int](0 + $LastExitCode)

Write-Host "rdoc --version:" $(rdoc --version)
$exit_code += [int](0 + $LastExitCode)

if ($exit_code -ne 0) { exit 1 }
