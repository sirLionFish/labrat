import React from 'react'
interface GreeterProps {
  name: string
}
const Greeter: React.FC<GreeterProps> = (props: GreeterProps) => {
  const name = props.name
  return (
    <section className='phx-hero'>
      <h1>Welcome to {name} with TypeScript and React!</h1>
    </section>
  )
}
export default Greeter
