export default function Gallery() {
  const galleryImages = [
    {
      src: "https://images.unsplash.com/photo-1489185078254-c3365d6e359f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
      alt: "Cinema interior with comfortable seating",
      title: "Comfortable Seating"
    },
    {
      src: "https://images.unsplash.com/photo-1594909122845-11baa439b7bf?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
      alt: "Cinema bar with drinks and snacks",
      title: "In-Auditorium Bar"
    },
    {
      src: "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
      alt: "Movie projection screen",
      title: "Premium Projection"
    },
    {
      src: "https://images.unsplash.com/photo-1536440136628-849c177e76a1?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
      alt: "Special event setup",
      title: "Special Events"
    },
    {
      src: "https://images.unsplash.com/photo-1578662996442-48f60103fc96?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
      alt: "Cozy cinema atmosphere",
      title: "Intimate Atmosphere"
    },
    {
      src: "https://images.unsplash.com/photo-1489185078254-c3365d6e359f?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80",
      alt: "Cinema entrance",
      title: "Welcome Area"
    }
  ]

  return (
    <section id="gallery" className="py-16 bg-black">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="text-center mb-12">
          <h2 className="text-3xl md:text-4xl font-bold text-white mb-4">
            Gallery
          </h2>
          <p className="text-lg text-gray-300 max-w-2xl mx-auto">
            Take a look inside Prague's most unique boutique cinema experience
          </p>
        </div>

        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
          {galleryImages.map((image, index) => (
            <div
              key={index}
              className="group relative overflow-hidden rounded-lg shadow-lg hover:shadow-xl transition-shadow duration-300"
            >
              <img
                src={image.src}
                alt={image.alt}
                className="w-full h-64 object-cover group-hover:scale-105 transition-transform duration-300"
              />
              <div className="absolute inset-0 bg-black bg-opacity-40 opacity-0 group-hover:opacity-100 transition-opacity duration-300 flex items-end">
                <div className="p-4 text-white">
                  <h3 className="text-lg font-semibold">{image.title}</h3>
                </div>
              </div>
            </div>
          ))}
        </div>

        <div className="text-center mt-12">
          <button className="bg-red-600 text-white px-8 py-3 rounded-lg hover:bg-red-700 transition-colors duration-200 font-medium">
            View More Photos
          </button>
        </div>
      </div>
    </section>
  )
}