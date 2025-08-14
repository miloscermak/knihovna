export default function MovieSchedule() {
  const movies = [
    {
      date: "Thursday 14/08",
      screenings: [
        { time: "17:30", title: "Duchoň", price: "230 Kč", status: "Running" },
        { time: "20:30", title: "Cans 4 Life", price: "230 Kč", status: "Running" }
      ]
    },
    {
      date: "Friday 15/08",
      screenings: [
        { time: "17:30", title: "Sorry, Baby", price: "230 Kč", status: "Running", lang: "ENG" },
        { time: "20:30", title: "Materialists", price: "230 Kč", status: "Running", lang: "ENG" }
      ]
    },
    {
      date: "Saturday 16/08",
      screenings: [
        { time: "14:15", title: "Materialists", price: "230 Kč", status: "Running", lang: "ENG" },
        { time: "17:30", title: "Cans 4 Life", price: "230 Kč", status: "Running" },
        { time: "20:30", title: "The Naked Gun (2025)", price: "230 Kč", status: "Running", lang: "ENG" }
      ]
    },
    {
      date: "Sunday 17/08",
      screenings: [
        { time: "17:15", title: "Materialists", price: "230 Kč", status: "Running", lang: "ENG" },
        { time: "20:30", title: "Summer School, 2001", price: "230 Kč", status: "Running" }
      ]
    }
  ]

  return (
    <section id="program" className="py-16 bg-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <h2 className="text-3xl md:text-4xl font-bold text-black mb-4">
            Current Program
          </h2>
          <p className="text-lg text-gray-600 max-w-2xl mx-auto">
            The best films from contemporary cinema, themed breakfasts, tastings, concerts, and lectures
          </p>
        </div>

        <div className="space-y-8">
          {movies.map((day, dayIndex) => (
            <div key={dayIndex} className="bg-black rounded-lg p-6">
              <h3 className="text-xl font-bold text-white mb-4">{day.date}</h3>
              <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
                {day.screenings.map((screening, index) => (
                  <div
                    key={index}
                    className="movie-card bg-white rounded-lg p-4 shadow-md hover:shadow-lg border border-gray-200"
                  >
                    <div className="flex justify-between items-start mb-3">
                      <div className="text-2xl font-bold text-red-600">
                        {screening.time}
                      </div>
                      {screening.lang && (
                        <span className="bg-black text-white text-xs font-medium px-2 py-1 rounded">
                          {screening.lang}
                        </span>
                      )}
                    </div>
                    <h4 className="text-lg font-semibold text-black mb-2">
                      {screening.title}
                    </h4>
                    <div className="flex justify-between items-center">
                      <span className="text-lg font-bold text-black">
                        {screening.price}
                      </span>
                      <button className="bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition-colors duration-200 text-sm font-medium">
                        Book Now
                      </button>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>

        <div className="text-center mt-12">
          <button className="bg-black text-white px-8 py-3 rounded-lg hover:bg-gray-800 transition-colors duration-200 font-medium">
            View All Screenings
          </button>
        </div>
      </div>
    </section>
  )
}