import { Module } from '@nestjs/common';
import { PrismaService } from './prisma/prisma.service';
import { CreateAccountController } from './employee/create-account.controller';
import { ConfigModule } from '@nestjs/config';
import { envSchema } from './env';
import { AuthModule } from './auth/auth.module';
import { AuthenticateController } from './auth/authenticate-controller';
import { EmployeeController } from './employee/employee-controller';

@Module({
  imports: [ConfigModule.forRoot({
    validate: (env) => envSchema.parse(env),
    isGlobal: true,
    }),
    AuthModule
  ],
  controllers: [CreateAccountController, AuthenticateController, EmployeeController],
  providers: [PrismaService],
})
export class AppModule { }
