-- CreateTable
CREATE TABLE "Workers" (
    "idWorker" SERIAL NOT NULL,
    "fullName" TEXT NOT NULL,
    "phoneNumber" TEXT,
    "document" TEXT NOT NULL,
    "photo" TEXT,
    "limit" DOUBLE PRECISION,
    "fullAccess" BOOLEAN NOT NULL DEFAULT false,
    "idCustomer" INTEGER,

    CONSTRAINT "Workers_pkey" PRIMARY KEY ("idWorker")
);

-- CreateTable
CREATE TABLE "Customers" (
    "idCustomer" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "lastName" TEXT,
    "mainPicture" TEXT,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "document" TEXT NOT NULL,
    "phoneNumber" TEXT,
    "idAddress" INTEGER,

    CONSTRAINT "Customers_pkey" PRIMARY KEY ("idCustomer")
);

-- CreateTable
CREATE TABLE "Addresses" (
    "idAddress" SERIAL NOT NULL,
    "zipCode" TEXT,
    "publicPlace" TEXT,
    "number" INTEGER,
    "neighborhood" TEXT,
    "complement" TEXT,
    "referencePoint" TEXT,
    "uf" TEXT,
    "latitude" TEXT,
    "longitude" TEXT,
    "idCity" INTEGER,

    CONSTRAINT "Addresses_pkey" PRIMARY KEY ("idAddress")
);

-- CreateTable
CREATE TABLE "Cities" (
    "idCity" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Cities_pkey" PRIMARY KEY ("idCity")
);

-- CreateTable
CREATE TABLE "Sales" (
    "idSale" SERIAL NOT NULL,
    "totalPrice" DOUBLE PRECISION NOT NULL,
    "saleTime" TIMESTAMP(3) NOT NULL,
    "description" TEXT,
    "idCustomer" INTEGER,
    "idWorker" INTEGER,

    CONSTRAINT "Sales_pkey" PRIMARY KEY ("idSale")
);

-- CreateTable
CREATE TABLE "saleProducts" (
    "idSaleProduct" SERIAL NOT NULL,
    "idSale" INTEGER NOT NULL,
    "idProduct" INTEGER NOT NULL,

    CONSTRAINT "saleProducts_pkey" PRIMARY KEY ("idSaleProduct")
);

-- CreateTable
CREATE TABLE "Products" (
    "idProduct" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "weight" DOUBLE PRECISION,
    "code" TEXT,
    "description" TEXT,
    "idCompany" INTEGER,

    CONSTRAINT "Products_pkey" PRIMARY KEY ("idProduct")
);

-- CreateTable
CREATE TABLE "Companies" (
    "idCompany" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "idAddress" INTEGER,
    "documentNumber" TEXT,
    "phoneNumber" TEXT,
    "corporateName" TEXT,
    "tradeName" TEXT,

    CONSTRAINT "Companies_pkey" PRIMARY KEY ("idCompany")
);

-- CreateTable
CREATE TABLE "companyEmployee" (
    "idCompanyUsersInt" SERIAL NOT NULL,
    "idCompany" INTEGER NOT NULL,
    "idEmployee" INTEGER NOT NULL,

    CONSTRAINT "companyEmployee_pkey" PRIMARY KEY ("idCompanyUsersInt")
);

-- CreateTable
CREATE TABLE "Employees" (
    "idEmployee" SERIAL NOT NULL,
    "idRole" INTEGER,
    "name" TEXT NOT NULL,
    "lastName" TEXT,
    "mainPicture" TEXT,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "document" TEXT NOT NULL,
    "phoneNumber" TEXT,

    CONSTRAINT "Employees_pkey" PRIMARY KEY ("idEmployee")
);

-- CreateTable
CREATE TABLE "Roles" (
    "idRole" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "alias" TEXT,

    CONSTRAINT "Roles_pkey" PRIMARY KEY ("idRole")
);

-- CreateTable
CREATE TABLE "companyCustomers" (
    "idCompanyCustomers" SERIAL NOT NULL,
    "idCompany" INTEGER NOT NULL,
    "idCustomer" INTEGER NOT NULL,

    CONSTRAINT "companyCustomers_pkey" PRIMARY KEY ("idCompanyCustomers")
);

-- CreateIndex
CREATE UNIQUE INDEX "Customers_email_key" ON "Customers"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Employees_email_key" ON "Employees"("email");

-- AddForeignKey
ALTER TABLE "Workers" ADD CONSTRAINT "Workers_idCustomer_fkey" FOREIGN KEY ("idCustomer") REFERENCES "Customers"("idCustomer") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Customers" ADD CONSTRAINT "Customers_idAddress_fkey" FOREIGN KEY ("idAddress") REFERENCES "Addresses"("idAddress") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Addresses" ADD CONSTRAINT "Addresses_idCity_fkey" FOREIGN KEY ("idCity") REFERENCES "Cities"("idCity") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sales" ADD CONSTRAINT "Sales_idCustomer_fkey" FOREIGN KEY ("idCustomer") REFERENCES "Customers"("idCustomer") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Sales" ADD CONSTRAINT "Sales_idWorker_fkey" FOREIGN KEY ("idWorker") REFERENCES "Workers"("idWorker") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "saleProducts" ADD CONSTRAINT "saleProducts_idSale_fkey" FOREIGN KEY ("idSale") REFERENCES "Sales"("idSale") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "saleProducts" ADD CONSTRAINT "saleProducts_idProduct_fkey" FOREIGN KEY ("idProduct") REFERENCES "Products"("idProduct") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Products" ADD CONSTRAINT "Products_idCompany_fkey" FOREIGN KEY ("idCompany") REFERENCES "Companies"("idCompany") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Companies" ADD CONSTRAINT "Companies_idAddress_fkey" FOREIGN KEY ("idAddress") REFERENCES "Addresses"("idAddress") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "companyEmployee" ADD CONSTRAINT "companyEmployee_idCompany_fkey" FOREIGN KEY ("idCompany") REFERENCES "Companies"("idCompany") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "companyEmployee" ADD CONSTRAINT "companyEmployee_idEmployee_fkey" FOREIGN KEY ("idEmployee") REFERENCES "Employees"("idEmployee") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employees" ADD CONSTRAINT "Employees_idRole_fkey" FOREIGN KEY ("idRole") REFERENCES "Roles"("idRole") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "companyCustomers" ADD CONSTRAINT "companyCustomers_idCompany_fkey" FOREIGN KEY ("idCompany") REFERENCES "Companies"("idCompany") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "companyCustomers" ADD CONSTRAINT "companyCustomers_idCustomer_fkey" FOREIGN KEY ("idCustomer") REFERENCES "Customers"("idCustomer") ON DELETE RESTRICT ON UPDATE CASCADE;
