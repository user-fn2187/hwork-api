import { Body, Controller, Get, UseGuards, UsePipes } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { ZodValidationPipe } from "src/pipes/zod-validation-pipe";
import { PrismaService } from "src/prisma/prisma.service";
import { z } from 'zod';

const employeeBodySchema = z.object({
    email: z.string().email(),
    password: z.string(),
});

type employeeBodySchema = z.infer<typeof employeeBodySchema>;

@Controller('/employee')
@UseGuards(AuthGuard('jwt'))
export class EmployeeController {
    constructor(
        private prisma: PrismaService,
    ) { }

    @Get()
    @UsePipes(new ZodValidationPipe(employeeBodySchema))
    async handle(@Body() body: employeeBodySchema) {
        
        return {message:'ok'}
    }
}