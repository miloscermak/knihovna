export default function Hero() {
  return (
    <section className="cinema-gradient text-white py-20">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center">
          <h1 className="text-4xl md:text-6xl font-bold mb-6 animate-fade-in">
            Knihovna Čermáka a Staňka
          </h1>
          <p className="text-xl md:text-2xl mb-8 text-gray-300 max-w-3xl mx-auto">
            Experience the best films from contemporary cinema with comfortable seating and a bar right in the auditorium
          </p>

          <div className="bg-red-600 text-white p-6 rounded-lg mb-8 max-w-4xl mx-auto">
            <h2 className="text-2xl font-bold mb-2">Featured Event</h2>
            <p className="text-lg">
              Finish the theatre summer holiday with an unforgettable one-woman show <strong>FLEABAG</strong> - August 31st at 20:30
            </p>
            <button className="mt-4 bg-white text-red-600 px-6 py-3 rounded-lg font-bold hover:bg-gray-100 transition-colors duration-200">
              Get Tickets
            </button>
          </div>

          <div className="flex flex-col sm:flex-row gap-4 justify-center">
            <button className="bg-white text-black px-8 py-3 rounded-lg font-bold hover:bg-gray-100 transition-all duration-200 transform hover:scale-105">
              View Program
            </button>
            <button className="border-2 border-white text-white px-8 py-3 rounded-lg font-bold hover:bg-white hover:text-black transition-all duration-200 transform hover:scale-105">
              Buy Kino Pass
            </button>
          </div>
        </div>
      </div>
    </section>
  )
}