export default function Features() {
  const features = [
    {
      title: "Boutique Cinema Experience",
      description: "Comfortable seating with a bar right in the auditorium for the ultimate viewing experience",
      icon: "🎬"
    },
    {
      title: "Contemporary Films",
      description: "Carefully curated selection of the best films from contemporary cinema",
      icon: "🎭"
    },
    {
      title: "Special Events",
      description: "Themed breakfasts, wine tastings, concerts, and lectures alongside our film program",
      icon: "🎪"
    },
    {
      title: "Kino Pass",
      description: "Get unlimited access to all screenings with our flexible cinema passes",
      icon: "🎫"
    }
  ]

  const passes = [
    { price: "500 CZK", description: "Basic Pass" },
    { price: "1100 CZK", description: "Standard Pass" },
    { price: "1650 CZK", description: "Premium Pass" },
    { price: "2300 CZK", description: "VIP Pass" }
  ]

  return (
    <section id="about" className="py-16 bg-black">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">
            Why Choose Čermák Staněk Comedy
          </h2>
          <p className="text-lg text-gray-300 max-w-2xl mx-auto">
            Experience cinema like never before in Prague's most unique boutique cinema
          </p>
        </div>

        <div className="grid gap-8 md:grid-cols-2 lg:grid-cols-4 mb-16">
          {features.map((feature, index) => (
            <div
              key={index}
              className="bg-white rounded-lg p-6 shadow-lg hover:shadow-xl transition-shadow duration-300 text-center"
            >
              <div className="text-4xl mb-4">{feature.icon}</div>
              <h3 className="text-xl font-semibold text-black mb-3">
                {feature.title}
              </h3>
              <p className="text-gray-600">
                {feature.description}
              </p>
            </div>
          ))}
        </div>

        <div className="text-center mb-12">
          <h2 className="text-3xl font-bold text-white mb-4">
            Kino Pass Options
          </h2>
          <p className="text-lg text-gray-300 max-w-2xl mx-auto mb-8">
            Choose the perfect pass for your cinema experience
          </p>

          <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
            {passes.map((pass, index) => (
              <div
                key={index}
                className="bg-white rounded-lg p-6 shadow-lg hover:shadow-xl transition-shadow duration-300 text-center border-2 border-gray-100 hover:border-red-500"
              >
                <div className="text-3xl font-bold text-red-600 mb-2">
                  {pass.price}
                </div>
                <h4 className="text-lg font-semibold text-black mb-4">
                  {pass.description}
                </h4>
                <button className="w-full bg-red-600 text-white px-4 py-2 rounded-lg hover:bg-red-700 transition-colors duration-200 font-medium">
                  Choose Plan
                </button>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  )
}