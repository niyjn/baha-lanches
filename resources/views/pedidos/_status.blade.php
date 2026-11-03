@php
    $cores = [
        'RECEBIDO' => 'text-bg-secondary',
        'EM_PREPARO' => 'text-bg-warning',
        'PRONTO' => 'text-bg-info',
        'SAIU_PARA_ENTREGA' => 'text-bg-primary',
        'ENTREGUE' => 'text-bg-success',
        'CANCELADO' => 'text-bg-danger',
    ];
@endphp
<span class="badge {{ $cores[$status] ?? 'text-bg-light' }}">{{ ucfirst(strtolower(str_replace('_', ' ', $status))) }}</span>
