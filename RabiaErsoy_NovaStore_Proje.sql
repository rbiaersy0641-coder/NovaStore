
-- =========================================
-- NOVASTORE E-TICARET VERI YONETIM SISTEMI
-- ASAMA 1: VERITABANI OLUSTURMA
-- =========================================

CREATE DATABASE NovaStoreDB;
GO

-- Veritabanini aktif hale getir
USE NovaStoreDB;
GO

-- Aktif veritabanini kontrol et
SELECT DB_NAME() AS AktifVeritabani;
GO


-- =========================================
-- ASAMA 2: CATEGORIES TABLOSU
-- =========================================

CREATE TABLE Categories
(
    CategoryID INT IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL,

    CONSTRAINT PK_Categories
    PRIMARY KEY (CategoryID)
);


GO

-- ASAMA: NOVASTORE KATEGORI KAYITLARI

INSERT INTO Categories (CategoryName)
VALUES
('Telefon ve Akýllý Aksesuarlar'),
('Ev Düzenleme'),
('Mutfak Gereçleri'),
('Seyahat ve Outdoor'),
('Çalýþma Alaný');

GO

-- =========================================
-- ASAMA 3: PRODUCTS TABLOSU
-- =========================================

CREATE TABLE Products
(
    ProductID INT IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2),
    Stock INT DEFAULT 0,
    CategoryID INT,

    CONSTRAINT PK_Products
    PRIMARY KEY (ProductID),

    CONSTRAINT FK_Products_Categories
    FOREIGN KEY (CategoryID)
    REFERENCES Categories(CategoryID)
);
GO


-- =========================================
-- ASAMA 4: CUSTOMERS TABLOSU
-- =========================================

CREATE TABLE Customers
(
    CustomerID INT IDENTITY(1,1),
    FullName VARCHAR(50),
    City VARCHAR(20),
    Email VARCHAR(100),

    CONSTRAINT PK_Customers
    PRIMARY KEY (CustomerID),

    CONSTRAINT UQ_Customers_Email
    UNIQUE (Email)
);
GO
  
  
-- =========================================
-- ASAMA 5: ORDERS TABLOSU
-- =========================================

CREATE TABLE Orders
(
    OrderID INT IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),

    CONSTRAINT PK_Orders
    PRIMARY KEY (OrderID),

    CONSTRAINT FK_Orders_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID)
);
GO


-- =========================================
-- ASAMA 6: ORDERDETAILS TABLOSU
-- =========================================

CREATE TABLE OrderDetails
(
    DetailID INT IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,

    CONSTRAINT PK_OrderDetails
    PRIMARY KEY (DetailID),

    CONSTRAINT FK_OrderDetails_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderDetails_Products
    FOREIGN KEY (ProductID)
    REFERENCES Products(ProductID)
);
GO


-- =========================================
-- ASAMA 7: KATEGORI VERILERININ KONTROLU
-- =========================================

SELECT * FROM Categories;
GO




-- ASAMA 8: KATEGORI ISIMLERINI GUNCELLEME

UPDATE Categories
SET CategoryName = N'Telefon ve Akýllý Aksesuarlar'
WHERE CategoryID = 1;

UPDATE Categories
SET CategoryName = N'Ev Düzenleme'
WHERE CategoryID = 2;

UPDATE Categories
SET CategoryName = N'Mutfak Gereçleri'
WHERE CategoryID = 3;

UPDATE Categories
SET CategoryName = N'Seyahat ve Outdoor'
WHERE CategoryID = 4;

UPDATE Categories
SET CategoryName = N'Çalýþma Alaný'
WHERE CategoryID = 5;

GO

-- KATEGORILERI KONTROL ET
SELECT * FROM Categories
ORDER BY CategoryID;

GO

-- ASAMA 9: URUN TABLOSU KONTROLU

SELECT * FROM Products;
GO


-- ASAMA 10: URUNLERI EKLEME

INSERT INTO Products (ProductName, Price, Stock, CategoryID)
VALUES
('Kablosuz Bluetooth Kulaklik', 1299.90, 20, 1),
('Hizli Sarj Powerbank', 899.90, 15, 1),
('Manyetik Telefon Tutucu', 449.90, 30, 1),
('Cok Amacli Cekmece Organizeri', 549.90, 18, 2),
('Dolap Ici Duzenleyici', 699.90, 25, 2),
('Paslanmaz Celik Termos', 799.90, 12, 3),
('Dijital Mutfak Tartisi', 499.90, 8, 3),
('Silikon Mutfak Gerecleri Seti', 649.90, 22, 3),
('Su Gecirmez Seyahat Cantasi', 1499.90, 7, 4),
('Valiz Ici Organizer Seti', 599.90, 16, 4),
('Ergonomik Laptop Standi', 899.90, 10, 5),
('Ayarlanabilir LED Masa Lambasi', 749.90, 14, 5);

GO

-- EKLENEN URUNLERI KONTROL ET
SELECT
    ProductID,
    ProductName,
    Price,
    Stock,
    CategoryID
FROM Products
ORDER BY ProductID;

GO


-- ASAMA 11: MUSTERI TABLOSU KONTROLU

SELECT * FROM Customers;
GO


-- ASAMA 12: MUSTERI KAYITLARINI EKLEME

INSERT INTO Customers (FullName, City, Email)
VALUES
('Deniz Arslan', 'Ankara', 'deniz.arslan@example.com'),
('Ece Yildiz', 'Istanbul', 'ece.yildiz@example.com'),
('Mert Kaya', 'Izmir', 'mert.kaya@example.com'),
('Selin Demir', 'Bursa', 'selin.demir@example.com'),
('Burak Aydin', 'Antalya', 'burak.aydin@example.com'),
('Elif Sahin', 'Konya', 'elif.sahin@example.com');

GO

-- MUSTERI KAYITLARINI KONTROL ET
SELECT
    CustomerID,
    FullName,
    City,
    Email
FROM Customers
ORDER BY CustomerID;

GO



-- ASAMA 13: SIPARIS TABLOSU KONTROLU

SELECT * FROM Orders;
GO


-- ASAMA 14: SIPARIS KAYITLARINI EKLEME

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2026-10-05T10:00:00', 2749.70),
(2, '2026-10-08T11:30:00', 1699.80),
(3, '2026-10-12T14:00:00', 1399.70),
(4, '2026-10-15T09:45:00', 1349.80),
(5, '2026-10-19T13:15:00', 2099.80),
(6, '2026-10-23T16:20:00', 2049.80),
(1, '2026-10-27T12:00:00', 2599.70),
(2, '2026-10-31T15:30:00', 2399.60),
(3, '2026-11-04T10:45:00', 2749.60),
(4, '2026-11-07T17:00:00', 2449.70);

GO

-- SIPARISLERI KONTROL ET
SELECT
    OrderID,
    CustomerID,
    OrderDate,
    TotalAmount
FROM Orders
ORDER BY OrderID;

GO

-- ASAMA 15: SIPARIS DETAY TABLOSU KONTROLU

SELECT * FROM OrderDetails;
GO



-- ASAMA 16: SIPARIS DETAYLARINI EKLEME

INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES
-- SIPARIS 1
(1, 1, 1),
(1, 4, 1),
(1, 11, 1),

-- SIPARIS 2
(2, 2, 1),
(2, 6, 1),

-- SIPARIS 3
(3, 3, 2),
(3, 7, 1),

-- SIPARIS 4
(4, 5, 1),
(4, 8, 1),

-- SIPARIS 5
(5, 9, 1),
(5, 10, 1),

-- SIPARIS 6
(6, 12, 1),
(6, 1, 1),

-- SIPARIS 7
(7, 2, 1),
(7, 6, 1),
(7, 11, 1),

-- SIPARIS 8
(8, 4, 2),
(8, 8, 2),

-- SIPARIS 9
(9, 5, 2),
(9, 10, 1),
(9, 12, 1),

-- SIPARIS 10
(10, 3, 1),
(10, 7, 1),
(10, 9, 1);

GO

-- SIPARIS DETAYLARINI KONTROL ET
SELECT * FROM OrderDetails
ORDER BY OrderID, DetailID;

GO


-- ASAMA 17: SIPARIS TUTARLARINI KONTROL ETME

SELECT
    O.OrderID,
    O.TotalAmount AS SiparisTutari,
    SUM(P.Price * OD.Quantity) AS HesaplananTutar
FROM Orders O
INNER JOIN OrderDetails OD
    ON O.OrderID = OD.OrderID
INNER JOIN Products P
    ON OD.ProductID = P.ProductID
GROUP BY
    O.OrderID,
    O.TotalAmount
ORDER BY O.OrderID;

GO


-- ASAMA 18: BIRLESIK SIPARIS RAPORU

SELECT
    O.OrderID,
    C.FullName AS MusteriAdi,
    C.City AS Sehir,
    O.OrderDate AS SiparisTarihi,
    P.ProductName AS UrunAdi,
    CAT.CategoryName AS Kategori,
    P.Price AS BirimFiyat,
    OD.Quantity AS Adet,
    P.Price * OD.Quantity AS SatirTutari
FROM Orders O
INNER JOIN Customers C
    ON O.CustomerID = C.CustomerID
INNER JOIN OrderDetails OD
    ON O.OrderID = OD.OrderID
INNER JOIN Products P
    ON OD.ProductID = P.ProductID
INNER JOIN Categories CAT
    ON P.CategoryID = CAT.CategoryID
ORDER BY O.OrderID;

GO


-- ASAMA 19: REFERANS BOLUM 3 - GOREV 1
-- STOK MIKTARI 20'DEN AZ OLAN URUNLER

SELECT
    ProductName,
    Stock
FROM Products
WHERE Stock < 20
ORDER BY Stock DESC;

GO


-- ASAMA 20: REFERANS BOLUM 3 - GOREV 2
-- MUSTERI VE SIPARIS BILGILERI

SELECT
    C.FullName AS MusteriAdi,
    C.City AS Sehir,
    O.OrderDate AS SiparisTarihi,
    O.TotalAmount AS ToplamTutar
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
ORDER BY O.OrderDate;

GO



-- SIPARIS SAYISINI TEKRAR KONTROL ET
SELECT *
FROM Orders
ORDER BY OrderID;

GO


-- AÞAMA 21: BELÝRLÝ MÜÞTERÝNÝN ALDIÐI ÜRÜNLER

SELECT
    C.FullName AS MusteriAdi,
    P.ProductName AS UrunAdi,
    P.Price AS BirimFiyat,
    OD.Quantity AS Adet,
    CAT.CategoryName AS KategoriAdi
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
INNER JOIN OrderDetails OD
    ON O.OrderID = OD.OrderID
INNER JOIN Products P
    ON OD.ProductID = P.ProductID
INNER JOIN Categories CAT
    ON P.CategoryID = CAT.CategoryID
WHERE C.FullName = 'Deniz Arslan'
ORDER BY O.OrderDate;
GO

-- AÞAMA 22: KATEGORÝLERE GÖRE ÜRÜN SAYISI

SELECT
    C.CategoryName AS KategoriAdi,
    COUNT(P.ProductID) AS UrunSayisi
FROM Categories C
LEFT JOIN Products P
    ON C.CategoryID = P.CategoryID
GROUP BY C.CategoryName
ORDER BY UrunSayisi DESC;
GO

-- ASAMA 23: MUSTERILERIN TOPLAM HARCAMASI

SELECT
    C.FullName AS MusteriAdi,
    SUM(O.TotalAmount) AS ToplamHarcama
FROM Customers C
INNER JOIN Orders O
    ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FullName
ORDER BY ToplamHarcama DESC;

GO


-- ASAMA 24: SIPARISLERIN UZERINDEN GECEN GUN SAYISI

SELECT
    OrderID,
    OrderDate AS SiparisTarihi,
    DATEDIFF(DAY, OrderDate, GETDATE()) AS GecenGun
FROM Orders
ORDER BY OrderDate;

GO


-- ASAMA 25: SIPARIS OZET VIEW OLUSTURMA

CREATE VIEW vw_SiparisOzet
AS
SELECT
    O.OrderID,
    C.FullName AS MusteriAdi,
    C.City AS Sehir,
    O.OrderDate AS SiparisTarihi,
    P.ProductName AS UrunAdi,
    OD.Quantity AS Adet,
    O.TotalAmount AS SiparisToplami
FROM Orders O
INNER JOIN Customers C
    ON O.CustomerID = C.CustomerID
INNER JOIN OrderDetails OD
    ON O.OrderID = OD.OrderID
INNER JOIN Products P
    ON OD.ProductID = P.ProductID;
GO




-- VIEW SONUCUNU KONTROL ET
SELECT *
FROM vw_SiparisOzet
ORDER BY OrderID;
GO




-- GÖREV: NovaStoreDB Veritabaný Yedekleme

BACKUP DATABASE NovaStoreDB
TO DISK = 'C:\Yedek\NovaStoreDB.bak'
WITH INIT,
NAME = 'NovaStoreDB Full Backup';
GO