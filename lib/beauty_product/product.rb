class BeautyProduct::Product

  attr_accessor :name, :price, :ingredients

  def products
    product_1 = self.new
    product_1.name = "Perfect Hair Day Conditioner Mini"
    product_1.price = "$11.00"
    product_1.ingredients = "-OFPMA: Provides a residue-free, weightless shield. Water, Cetearyl Alcohol, Behentrimonium Chloride, Octafluoropentyl Methacrylate (OFPMA), Cetyl Alcohol, Quaternium-87, PPG-3 Benzyl Ether Ethylhexanoate, Behenyl/Stearyl Aminopropanediol Esters, Linoleamidopropyl Dimethylamine Dimer Dilinoleate, Guar Hydroxypropyltrimonium Chloride, Hydroxyethylcellulose, Caesalpinia Spinosa Gum, Steareth-2, Steareth-10, Fragrance/Parfum, Citric Acid, Methylchloroisothiazolinone, Methylisothiazolinone, Limonene, Hexyl Cinnamal, Linalool, Citronellol, Butylphenyl Methylpropional, Magnesium Nitrate, Magnesium Chloride."

    product_2 = self.new
    product_2.name = "Restore Conditioner Mini"
    product_2.price = "$13.00"
    product_2.ingredients = "-PolyfluoroEster : Reduces hair's porosity, -Creatine: Smooths the cuticle, -Hydrolized Wheat Protein: Builds strength by targeting dry or damaged sites on the hair to condition and protect against further damage, Water, Sodium Lauroyl Methyl Isethionate, Cocamidopropyl Betaine, Sodium Methyl Cocoyl Taurate, Glycol Distearate, Lactamide MEA, Fragrance/Parfum, PEG-200 Hydrogenated Glyceryl Palmate, Octafluoropentyl Methacrylate (PolyfluoroEster), Creatine, Laureth-23, Tetrasodium EDTA, PEG-7 Glyceryl Cocoate, Hydrolyzed Wheat Protein, Polyquaternium-47, Behenyl Alcohol, Laureth-16, Laureth-4, Polyquaternium-52, PEG-150 Pentaerythrityl Tetrastearate, PEG-6 Caprylic/Capric Glyceride, Methylchloroisothiazolinone, Methylisothiazolinone, Limonene, Hexyl Cinnamal, Linalool, Citronellol, Butylphenyl Methylpropional."

    [product_1, product_2]
  end # product

  def product_name
    

end # class BeautyProduct::Product
