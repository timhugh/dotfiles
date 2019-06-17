set tabstop=4
set shiftwidth=4
set noexpandtab

" let lombok_jar_path=$HOME . "/.m2/repository/org/projectlombok/lombok/1.18.0/lombok-1.18.0.jar"
" let $JAVA_TOOL_OPTIONS="-javaagent:" . lombok_jar_path . " -Xbootclasspath/p:" . lombok_jar_path
let test#java#maventest#options = "-DfailIfNoTests=false"
