import { useState } from 'react'

export default function Header() {
  const [isMenuOpen, setIsMenuOpen] = useState(false)

  return (
    <header className="bg-black shadow-lg sticky top-0 z-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          <div className="flex items-center">
            <h1 className="text-2xl font-bold text-white">Čermák Staněk Comedy</h1>
          </div>

          <nav className="hidden md:flex space-x-8">
            <a href="#program" className="text-white hover:text-red-500 transition-colors duration-200 font-medium">
              Program
            </a>
            <a href="#about" className="text-white hover:text-red-500 transition-colors duration-200 font-medium">
              About
            </a>
            <a href="#gallery" className="text-white hover:text-red-500 transition-colors duration-200 font-medium">
              Gallery
            </a>
            <a href="#contact" className="text-white hover:text-red-500 transition-colors duration-200 font-medium">
              Contact
            </a>
          </nav>

          <div className="hidden md:flex items-center space-x-4">
            <button className="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition-colors duration-200 font-medium">
              Buy Tickets
            </button>
          </div>

          <div className="md:hidden">
            <button
              onClick={() => setIsMenuOpen(!isMenuOpen)}
              className="text-white hover:text-red-500 transition-colors duration-200"
            >
              <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 6h16M4 12h16M4 18h16" />
              </svg>
            </button>
          </div>
        </div>

        {isMenuOpen && (
          <div className="md:hidden bg-black border-t border-gray-800">
            <div className="px-2 pt-2 pb-3 space-y-1">
              <a href="#program" className="block px-3 py-2 text-white hover:text-red-500 transition-colors duration-200">
                Program
              </a>
              <a href="#about" className="block px-3 py-2 text-white hover:text-red-500 transition-colors duration-200">
                About
              </a>
              <a href="#gallery" className="block px-3 py-2 text-white hover:text-red-500 transition-colors duration-200">
                Gallery
              </a>
              <a href="#contact" className="block px-3 py-2 text-white hover:text-red-500 transition-colors duration-200">
                Contact
              </a>
              <button className="w-full mt-2 bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition-colors duration-200">
                Buy Tickets
              </button>
            </div>
          </div>
        )}
      </div>
    </header>
  )
}