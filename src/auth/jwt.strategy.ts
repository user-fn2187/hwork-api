import { Injectable } from "@nestjs/common";
import { ConfigService } from "@nestjs/config";
import { PassportStrategy } from "@nestjs/passport";
import { Strategy, ExtractJwt} from "passport-jwt";
import { Env } from "src/env";
import { z } from "zod";

const tokenBodySchema = z.object({
    sub: z.string(),
})
type TokenBodySchema = z.infer<typeof tokenBodySchema>;

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy){
    constructor(config: ConfigService<Env, true>){
        const publicKey = config.get('JWT_PUBLIC_KEY',{infer:true})
        super({
            jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
            ignoreExpiration: false,
            secretOrKey: Buffer.from(publicKey,'base64'),
            algorithms: ['RS256']
        })
    }

    async validate(payload: TokenBodySchema) {
        return tokenBodySchema.parse(payload);
      }
}