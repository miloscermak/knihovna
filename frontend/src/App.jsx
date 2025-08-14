import Header from './components/Header'
import Hero from './components/Hero'
import MovieSchedule from './components/MovieSchedule'
import Features from './components/Features'
import Gallery from './components/Gallery'
import Newsletter from './components/Newsletter'
import Footer from './components/Footer'

function App() {
  return (
    <div className="min-h-screen bg-gray-50">
      <Header />
      <Hero />
      <MovieSchedule />
      <Features />
      <Gallery />
      <Newsletter />
      <Footer />
    </div>
  )
}

export default App