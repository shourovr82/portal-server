-- CreateEnum
CREATE TYPE "UserRoles" AS ENUM ('SUPERADMIN', 'ADMIN', 'USER');

-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('Active', 'Paused', 'Suspended');

-- CreateEnum
CREATE TYPE "IssueStatus" AS ENUM ('Solved', 'Working', 'NotPossible', 'Hold', 'New', 'AlreadyFixed');

-- CreateEnum
CREATE TYPE "IssueLists" AS ENUM ('troubleLoggingIn', 'forgotEmail', 'forgotPassword', 'loadingIssues', 'accountDeactivation', 'securityConcerns', 'technicalGlitches', 'featureRequest', 'paymentIssue', 'uiFeedback', 'accountRecovery', 'other');

-- CreateTable
CREATE TABLE "users" (
    "userId" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "userStatus" "UserStatus" NOT NULL DEFAULT 'Active',
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,
    "profileId" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "profiles" (
    "profileId" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "profileImage" TEXT,
    "role" "UserRoles" NOT NULL DEFAULT 'USER',
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,

    CONSTRAINT "profiles_pkey" PRIMARY KEY ("profileId")
);

-- CreateTable
CREATE TABLE "factories" (
    "factoryId" TEXT NOT NULL,
    "factoryName" TEXT NOT NULL,
    "factoryAddress" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,

    CONSTRAINT "factories_pkey" PRIMARY KEY ("factoryId")
);

-- CreateTable
CREATE TABLE "styles" (
    "styleNo" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "fabric" TEXT NOT NULL,
    "isActiveStyle" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,
    "profileId" TEXT NOT NULL,
    "factoryId" TEXT,
    "itemId" TEXT NOT NULL,

    CONSTRAINT "styles_pkey" PRIMARY KEY ("styleNo")
);

-- CreateTable
CREATE TABLE "pp_submission" (
    "ppSubmissionId" TEXT NOT NULL,
    "factorySubmissionDate" TIMESTAMP(3) NOT NULL,
    "factorySubmittedDate" TIMESTAMP(3),
    "delayDays" INTEGER,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,
    "styleNo" TEXT NOT NULL,

    CONSTRAINT "pp_submission_pkey" PRIMARY KEY ("ppSubmissionId")
);

-- CreateTable
CREATE TABLE "items" (
    "itemId" TEXT NOT NULL,
    "itemName" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,

    CONSTRAINT "items_pkey" PRIMARY KEY ("itemId")
);

-- CreateTable
CREATE TABLE "orders" (
    "orderNo" TEXT NOT NULL,
    "noOfPack" INTEGER NOT NULL,
    "totalPack" INTEGER NOT NULL,
    "totalPc" INTEGER NOT NULL,
    "isActiveOrder" BOOLEAN NOT NULL DEFAULT true,
    "buyerEtd" TIMESTAMP(3) NOT NULL,
    "factoryEtd" TIMESTAMP(3) NOT NULL,
    "friDate" TIMESTAMP(3) NOT NULL,
    "orderFile" TEXT,
    "styleNo" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,
    "portId" TEXT NOT NULL,
    "profileId" TEXT NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("orderNo")
);

-- CreateTable
CREATE TABLE "tackpack" (
    "tackPackId" TEXT NOT NULL,
    "tackPackComment" TEXT NOT NULL,
    "tackFile" TEXT NOT NULL,
    "profileId" TEXT NOT NULL,
    "styleNo" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,

    CONSTRAINT "tackpack_pkey" PRIMARY KEY ("tackPackId")
);

-- CreateTable
CREATE TABLE "port_addresses" (
    "portId" TEXT NOT NULL,
    "portName" TEXT NOT NULL,
    "portAddress" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,

    CONSTRAINT "port_addresses_pkey" PRIMARY KEY ("portId")
);

-- CreateTable
CREATE TABLE "pp_strike_off_status" (
    "ppStatusId" TEXT NOT NULL,
    "ppStatusComment" TEXT NOT NULL,
    "styleNo" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,
    "profileId" TEXT NOT NULL,

    CONSTRAINT "pp_strike_off_status_pkey" PRIMARY KEY ("ppStatusId")
);

-- CreateTable
CREATE TABLE "bulk_production_status" (
    "bulkProductionId" TEXT NOT NULL,
    "bulkProductionComment" TEXT NOT NULL,
    "styleNo" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,
    "profileId" TEXT NOT NULL,

    CONSTRAINT "bulk_production_status_pkey" PRIMARY KEY ("bulkProductionId")
);

-- CreateTable
CREATE TABLE "ldCpAopStatus" (
    "ldCpAopStatusId" TEXT NOT NULL,
    "ldCpAopStatusComment" TEXT NOT NULL,
    "styleNo" TEXT NOT NULL,
    "profileId" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,

    CONSTRAINT "ldCpAopStatus_pkey" PRIMARY KEY ("ldCpAopStatusId")
);

-- CreateTable
CREATE TABLE "courier_details" (
    "courierId" TEXT NOT NULL,
    "courierName" TEXT NOT NULL,
    "awbNo" TEXT NOT NULL,
    "courierDate" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "courierDetails" TEXT NOT NULL,
    "styleNo" TEXT NOT NULL,
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,

    CONSTRAINT "courier_details_pkey" PRIMARY KEY ("courierId")
);

-- CreateTable
CREATE TABLE "problem_reports" (
    "problemReportsId" TEXT NOT NULL,
    "issueName" "IssueLists" NOT NULL,
    "emailAddress" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "problemStatus" "IssueStatus" NOT NULL DEFAULT 'New',
    "createdAt" TIMESTAMPTZ(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMPTZ(0) NOT NULL,

    CONSTRAINT "problem_reports_pkey" PRIMARY KEY ("problemReportsId")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_profileId_key" ON "users"("profileId");

-- CreateIndex
CREATE UNIQUE INDEX "factories_factoryName_key" ON "factories"("factoryName");

-- CreateIndex
CREATE UNIQUE INDEX "styles_styleNo_key" ON "styles"("styleNo");

-- CreateIndex
CREATE UNIQUE INDEX "pp_submission_styleNo_key" ON "pp_submission"("styleNo");

-- CreateIndex
CREATE UNIQUE INDEX "items_itemName_key" ON "items"("itemName");

-- CreateIndex
CREATE UNIQUE INDEX "orders_orderNo_key" ON "orders"("orderNo");

-- CreateIndex
CREATE UNIQUE INDEX "tackpack_styleNo_key" ON "tackpack"("styleNo");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "profiles"("profileId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "styles" ADD CONSTRAINT "styles_factoryId_fkey" FOREIGN KEY ("factoryId") REFERENCES "factories"("factoryId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "styles" ADD CONSTRAINT "styles_itemId_fkey" FOREIGN KEY ("itemId") REFERENCES "items"("itemId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "styles" ADD CONSTRAINT "styles_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "profiles"("profileId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pp_submission" ADD CONSTRAINT "pp_submission_styleNo_fkey" FOREIGN KEY ("styleNo") REFERENCES "styles"("styleNo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_portId_fkey" FOREIGN KEY ("portId") REFERENCES "port_addresses"("portId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "profiles"("profileId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_styleNo_fkey" FOREIGN KEY ("styleNo") REFERENCES "styles"("styleNo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tackpack" ADD CONSTRAINT "tackpack_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "profiles"("profileId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tackpack" ADD CONSTRAINT "tackpack_styleNo_fkey" FOREIGN KEY ("styleNo") REFERENCES "styles"("styleNo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pp_strike_off_status" ADD CONSTRAINT "pp_strike_off_status_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "profiles"("profileId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "pp_strike_off_status" ADD CONSTRAINT "pp_strike_off_status_styleNo_fkey" FOREIGN KEY ("styleNo") REFERENCES "styles"("styleNo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bulk_production_status" ADD CONSTRAINT "bulk_production_status_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "profiles"("profileId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "bulk_production_status" ADD CONSTRAINT "bulk_production_status_styleNo_fkey" FOREIGN KEY ("styleNo") REFERENCES "styles"("styleNo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ldCpAopStatus" ADD CONSTRAINT "ldCpAopStatus_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "profiles"("profileId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ldCpAopStatus" ADD CONSTRAINT "ldCpAopStatus_styleNo_fkey" FOREIGN KEY ("styleNo") REFERENCES "styles"("styleNo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "courier_details" ADD CONSTRAINT "courier_details_styleNo_fkey" FOREIGN KEY ("styleNo") REFERENCES "styles"("styleNo") ON DELETE RESTRICT ON UPDATE CASCADE;
