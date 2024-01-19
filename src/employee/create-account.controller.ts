import { Body, ConflictException, Controller, HttpCode, Post, UsePipes } from "@nestjs/common";
import { PrismaService } from "src/prisma/prisma.service";
import { hash } from 'bcryptjs';
import { z } from 'zod';
import { PipesConsumer } from "@nestjs/core/pipes";
import { ZodValidationPipe } from "src/pipes/zod-validation-pipe";

const createAccountBodySchema = z.object({
    name: z.string(),
    email: z.string().email(),
    password: z.string(),
    document: z.string()
});

type CreateAccountBodySchema = z.infer<typeof createAccountBodySchema>;

@Controller('employee')
export class CreateAccountController {
    constructor(private prisma: PrismaService) { }
    @Post()
    @UsePipes(new ZodValidationPipe(createAccountBodySchema))
    async handle(@Body() body: CreateAccountBodySchema) {
        const { name, email, password, document } = body;
        
        const userWithSameEmail = await this.prisma.employee.findUnique({
            where: {
                email,
            },
        });

        if(userWithSameEmail){
            throw new ConflictException('User with the same email adress already exists.');
        }

        const hashedPassword = await hash(password, 8);

        await this.prisma.employee.create({
            data: {
                name,
                email,
                password:hashedPassword,
                document
            }
        });
    }
}