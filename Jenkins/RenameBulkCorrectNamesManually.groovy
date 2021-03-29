// TODO: Allow provision of names/parts via arguments!
for (item in Hudson.instance.items) {
    name = item.name
    if (name.startsWith('START')) {
        if (name.endsWith('END')) {
          def newName = name.replaceAll('TO_REPLACE','REPLACE_WITH')
          item.renameTo(newName)
        }
    }
}