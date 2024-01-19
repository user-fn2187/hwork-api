import { Body, Controller, Post, UnauthorizedException, UsePipes } from "@nestjs/common";
import { JwtService } from "@nestjs/jwt";
import { compare } from "bcryptjs";
import { ZodValidationPipe } from "src/pipes/zod-validation-pipe";
import { PrismaService } from "src/prisma/prisma.service";
import { z } from 'zod';

const authenticateBodySchema = z.object({
    email: z.string().email(),
    password: z.string(),
});

type authenticateBodySchema = z.infer<typeof authenticateBodySchema>;

@Controller('sessions')
export class AuthenticateController {
    constructor(
        private prisma: PrismaService,
        private jwt: JwtService
    ) { }

    @Post('employee')
    @UsePipes(new ZodValidationPipe(authenticateBodySchema))
    async authEmployee(@Body() body: authenticateBodySchema) {
        const { password, email } = body;

        const employeeAccount = await this.prisma.employee.findUnique({
            where:{
                email
            }
        })
        
        if(!employeeAccount){
            throw new UnauthorizedException('Employee credentials do not match.')
        }

        const isValidPassword = compare(password, employeeAccount.password)
        if(!isValidPassword){
            throw new UnauthorizedException('Employee credentials do not mathc.')
        }

        const accessToken = this.jwt.sign({ sub: employeeAccount.idEmployee })

        return {
            acesss_token: accessToken
        }
    }

    @Post('custumer')
    @UsePipes(new ZodValidationPipe(authenticateBodySchema))
    async authCustumers(@Body() body: authenticateBodySchema) {
        const { password, email } = body;

        const customerAccount = await this.prisma.customer.findUnique({
            where:{
                email
            }
        })
        
        if(!customerAccount){
            throw new UnauthorizedException('Custumer credentials do not match.')
        }

        const isValidPassword = compare(password, customerAccount.password)
        if(!isValidPassword){
            throw new UnauthorizedException('Custumer credentials do not mathc.')
        }

        const accessToken = this.jwt.sign({ sub: customerAccount.idCustomer })

        return {
            acesss_token: accessToken
        }
    }
}