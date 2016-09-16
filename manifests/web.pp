class moodle::web (
  $web = ''

){
  if $web != '' {
    case $web {
      apache: { class{'moodle::web::apache':}}
      default: { notify{"${web} not yet implemented":}}
    }
  }
}
