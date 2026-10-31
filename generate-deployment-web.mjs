// Generate browser enum constants from the authoritative protocol definition.
import {readFileSync,writeFileSync} from 'node:fs'
const source=readFileSync(new URL('./deployment_agent.proto',import.meta.url),'utf8')
let output='// Generated from proto/deployment_agent.proto. Do not edit.\n'
for(const [,name,body] of source.matchAll(/enum\s+(\w+)\s*\{([^}]+)\}/g)){
 const entries=[...body.matchAll(/(\w+)\s*=\s*(\d+)\s*;/g)].map(([,key,value])=>`  ${key}: ${value}`)
 output+=`export const ${name} = Object.freeze({\n${entries.join(',\n')}\n})\n`
}
writeFileSync(new URL('../slotadmin/web/src/api/deploymentEnums.js',import.meta.url),output)
